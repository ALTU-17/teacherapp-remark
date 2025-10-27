## TeacherApp - API & Module Documentation

### Overview
This document summarizes app modules, key features, providers/services, and the HTTP API endpoints used by the app. All network requests use Dio via `apiClient.post` with the base URL coming from `teacherVerification.teacherapkUrl`. Many endpoints live under `AdminApi/`.

### Conventions
- Auth context values included in many requests: `academic_yr`, `short_name`, `teacher_id`
- Attendance payload items use strings for statuses: `attendance_status` is "1" (present/marked) or "0" (absent/unmarked)
- Many POST bodies are submitted using `FormData.fromMap(...)`

---

### Daily Attendance
- Features: Load students for a class/date, update attendance, delete attendance
- Provider: `AttendanceP`
- Service: `AttendanceService`

Endpoints

| Method | Endpoint | Purpose |
|---|---|---|
| POST | `AdminApi/get_attendance_students` | Fetch students for a class/date |
| POST | `AdminApi/update_attendance` | Save/Update attendance data |
| POST | `AdminApi/mark_attendance` | Delete attendance (`operation=delete_attendance`) |

Request bodies (core fields)

Fetch students

```json
{
  "academic_yr": "YYYY-YYYY",
  "class_id": "...",
  "section_id": "...",
  "only_date": "YYYY-MM-DD",
  "short_name": "..."
}
```

Update attendance

```json
{
  "academic_yr": "YYYY-YYYY",
  "class_id": "...",
  "section_id": "...",
  "only_date": "YYYY-MM-DD",
  "short_name": "...",
  "teacher_id": "...",
  "data": "[ { \"arraylist\": [ {\"attendance_status\":\"1\",\"fName\":\"...\",...} ] } ]",
  "login_type": "T",
  "operation": "check_insert"
}
```

Delete attendance

```json
{
  "academic_yr": "YYYY-YYYY",
  "class_id": "...",
  "section_id": "...",
  "only_date": "YYYY-MM-DD",
  "short_name": "...",
  "teacher_id": "...",
  "data": "[ { \"arraylist\": [ {\"attendance_status\":\"0\",\"student_id\":\"...\"} ] } ]",
  "login_type": "T",
  "operation": "delete_attendance"
}
```

Important models
- `Students`: response model for `get_attendance_students`
- `Att`: request item for updates/deletes: `{ attendance_status, fName, lName, rollno, student_id, classid, sectionid, date, only_date, teacher_id, academic_yr }`

---

### Homework
- Features: List homework, create/update, publish, per-student view status, attachments
- Service: `HomeworkService`

Endpoints

| Method | Endpoint | Purpose |
|---|---|---|
| POST | `AdminApi/get_homework` | List homework |
| POST | `AdminApi/homework` | Create/Update homework (multiple operations) |
| POST | `AdminApi/get_subject_alloted_to_teacher_by_class` | Subjects by class |
| POST | `AdminApi/get_subject_alloted_to_teacher_by_multiple_class` | Subjects by multiple classes |
| POST | `AdminApi/getClassAndSection_teacheralloted` | Classes/sections for teacher |
| POST | `AdminApi/get_student_with_homework_status` | Homework view status |
| POST | `AdminApi/updateHomework` | Update/publish homework data |
| POST | `AdminApi/get_students_homework_viewed` | Viewer list |
| POST | `AdminApi/upload_files` | Upload attachments |
| POST | `AdminApi/get_images_homework` | Fetch attachments |
| POST | `AdminApi/delete_uploaded_files` | Delete attachments |

Notes
- Many bodies include `academic_yr`, `short_name`, `teacher_id`
- Some calls add `loginType: 'T'`
- Attachments use dedicated models (e.g., `upload_doc_body.dart`)

---

### Teacher Notes
- Features: List notes, create/update, attachments, view status, subject/class lookup
- Service: `TeacherNoteService`

Endpoints

| Method | Endpoint | Purpose |
|---|---|---|
| POST | `AdminApi/get_daily_notes` | List notes |
| POST | `AdminApi/daily_notes` | Create/Update notes (multiple operations) |
| POST | `AdminApi/upload_files` | Upload note attachments |
| POST | `AdminApi/get_images_daily_notes` | Fetch note attachments |
| POST | `AdminApi/get_subject_alloted_to_teacher_by_multiple_class` | Subjects by multiple classes |
| POST | `AdminApi/delete_uploaded_files` | Delete note attachments |
| POST | `AdminApi/get_students_notes_viewed` | Viewers |

---

### Authentication
- Features: Validate teacher account, change/reset password, settings, teacher profile
- Service: `AuthService`

Endpoints

| Method | Endpoint | Purpose |
|---|---|---|
| POST | `/validate_teacher_user` | Validate teacher (base path, not under AdminApi) |
| POST | `AdminApi/change_password` | Change password |
| POST | `AdminApi/reset_password` | Reset password |
| POST | `AdminApi/get_settings_data` | App settings |
| POST | `AdminApi/teachers` | Teacher profile info |

---

### Classes & Timetable
- Features: Teacher timetable, classes and sections for teacher
- Services: `ClasssService` (for attendance), timetable service located in `views/home/timeTable/timeTableTecaher.dart`

Endpoints

| Method | Endpoint | Purpose |
|---|---|---|
| POST | `AdminApi/get_teacher_timetable` | Teacher timetable |
| POST | `AdminApi/getClassAndSection_teacheralloted` | Classes and sections for teacher |
| POST | `AdminApi/get_subject_alloted_to_teacher_by_class` | Subjects by class |
| POST | `AdminApi/get_subject_alloted_to_teacher_by_multiple_class` | Subjects by multiple classes |

---

### Home (Academic Year & Calendar)
- Features: Change academic year, view calendar events
- Services: `AcademicYearService`, `CalenderService`

Notes
- Endpoints use Admin API; bodies include `academic_yr`, `short_name` and filters
- See `lib/features/home/services/*.dart` for exact payloads

---

### Leave Application
- Features: Apply leave, list leaves; teacher-centric operations
- Service: `LeaveService`

Notes
- Endpoints under Admin API using `apiClient.post`, include identity and academic year fields
- See `lib/features/leave_application/services/*.dart`

---

### Curriculum
- Features: Chapters, lesson plan headings, templates
- Services: `CurriculumService`, `CreateChapterService`, `ChapterService`, `LessonPlanHeadingService`

Notes
- Endpoints under Admin API; typical fields include `academic_yr`, `short_name`, and curriculum-specific fields
- See `lib/features/curriculum/services/*.dart`

---

### Data Models (Selected)
- `Students`: response from `get_attendance_students`
- `Att`: attendance payload item
  - Fields: `attendance_status`, `fName`, `lName`, `rollno`, `student_id`, `classid`, `sectionid`, `date`, `only_date`, `teacher_id`, `academic_yr`
- `StudentBody`: request body for fetching attendance students
- Homework/Notes: multiple dedicated bodies for operations and attachments

---

### Error Handling & Responses
- Most endpoints return `{ status: boolean, ... }` and additional payload arrays (e.g., `students`)
- The app checks for `status == true` to consider operations successful


