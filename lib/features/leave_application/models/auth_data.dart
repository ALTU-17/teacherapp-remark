class AuthData {
  final String shortName;
  final String url;
  final String regId;
  final String academicYr;
  AuthData({
    required this.shortName,
    required this.url,
    required this.regId,
    required this.academicYr,
  });

  bool get isValid =>
      shortName.isNotEmpty &&
      url.isNotEmpty &&
      regId.isNotEmpty &&
      academicYr.isNotEmpty;
}
