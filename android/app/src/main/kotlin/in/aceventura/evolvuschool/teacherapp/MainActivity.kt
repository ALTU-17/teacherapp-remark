package `in`.aceventura.evolvuschool.teacherapp

import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Parcelable
import android.provider.OpenableColumns
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

class MainActivity : FlutterActivity() {
    private val sharedAttachmentChannel = "teacherapp/shared_attachments"
    private var methodChannel: MethodChannel? = null
    private var initialSharedFiles: List<Map<String, Any?>> = emptyList()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            sharedAttachmentChannel
        )
        methodChannel?.setMethodCallHandler { call, result ->
            when (call.method) {
                "getInitialSharedFiles" -> {
                    result.success(initialSharedFiles)
                    initialSharedFiles = emptyList()
                }
                else -> result.notImplemented()
            }
        }

        initialSharedFiles = readSharedFiles(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        val sharedFiles = readSharedFiles(intent)
        if (sharedFiles.isNotEmpty()) {
            methodChannel?.invokeMethod("onSharedFiles", sharedFiles)
        }
    }

    private fun readSharedFiles(intent: Intent?): List<Map<String, Any?>> {
        val uris = getSharedUris(intent)
        if (uris.isEmpty()) return emptyList()

        val files = mutableListOf<Map<String, Any?>>()
        for (uri in uris) {
            copySharedUriToCache(uri, intent?.type)?.let { files.add(it) }
        }
        return files
    }

    private fun getSharedUris(intent: Intent?): List<Uri> {
        if (intent == null) return emptyList()
        return when (intent.action) {
            Intent.ACTION_SEND -> getSingleStreamUri(intent)?.let { listOf(it) } ?: emptyList()
            Intent.ACTION_SEND_MULTIPLE -> getMultipleStreamUris(intent)
            else -> emptyList()
        }
    }

    @Suppress("DEPRECATION")
    private fun getSingleStreamUri(intent: Intent): Uri? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            intent.getParcelableExtra(Intent.EXTRA_STREAM, Uri::class.java)
        } else {
            intent.getParcelableExtra<Parcelable>(Intent.EXTRA_STREAM) as? Uri
        }
    }

    @Suppress("DEPRECATION")
    private fun getMultipleStreamUris(intent: Intent): List<Uri> {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            intent.getParcelableArrayListExtra(Intent.EXTRA_STREAM, Uri::class.java)
                ?: emptyList()
        } else {
            intent.getParcelableArrayListExtra<Parcelable>(Intent.EXTRA_STREAM)
                ?.filterIsInstance<Uri>()
                ?: emptyList()
        }
    }

    private fun copySharedUriToCache(uri: Uri, fallbackMimeType: String?): Map<String, Any?>? {
        val displayName = queryDisplayName(uri)
            ?: uri.lastPathSegment?.substringAfterLast('/')
            ?: "shared_file"
        val safeName = displayName.replace(Regex("[^A-Za-z0-9._-]"), "_")
            .ifBlank { "shared_file" }
        val shareDir = File(cacheDir, "shared_attachments").apply { mkdirs() }
        val destination = File(shareDir, "${System.currentTimeMillis()}_$safeName")

        return try {
            contentResolver.openInputStream(uri)?.use { input ->
                FileOutputStream(destination).use { output ->
                    input.copyTo(output)
                }
            } ?: return null

            mapOf(
                "name" to safeName,
                "path" to destination.absolutePath,
                "mimeType" to (contentResolver.getType(uri) ?: fallbackMimeType),
                "size" to destination.length()
            )
        } catch (_: Exception) {
            null
        }
    }

    private fun queryDisplayName(uri: Uri): String? {
        return try {
            contentResolver.query(uri, null, null, null, null)?.use { cursor ->
                val nameIndex = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME)
                if (nameIndex >= 0 && cursor.moveToFirst()) {
                    cursor.getString(nameIndex)
                } else {
                    null
                }
            }
        } catch (_: Exception) {
            null
        }
    }
}
