import 'package:flutter/material.dart';

// Add this helper class
class TextSanitizer {
  // Remove HTML/PHP tags and decode HTML entities
  static String cleanText(String text) {
    if (text.isEmpty) return '';

    String cleaned = text;

    // Decode HTML entities
    cleaned = cleaned
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'");

    // Remove PHP tags
    cleaned = cleaned.replaceAll(
      RegExp(r'<\?(?:php)?[\s\S]*?\?>', caseSensitive: false),
      '',
    );

    // Remove script/style blocks
    cleaned = cleaned.replaceAll(
      RegExp(r'<script[^>]*>[\s\S]*?</script>', caseSensitive: false),
      '',
    );

    cleaned = cleaned.replaceAll(
      RegExp(r'<style[^>]*>[\s\S]*?</style>', caseSensitive: false),
      '',
    );

    // Remove all HTML tags
    cleaned = cleaned.replaceAll(RegExp(r'<[^>]+>'), '');

    // Remove extra spaces
    cleaned = cleaned.replaceAll(RegExp(r'\s+'), ' ').trim();

    return cleaned;
  }

  // Alternative: Use a more aggressive approach to remove any <? ?> tags
  static String removePhpTags(String text) {
    return text.replaceAll(RegExp(r'<\?.*?\?>'), '').trim();
  }
}