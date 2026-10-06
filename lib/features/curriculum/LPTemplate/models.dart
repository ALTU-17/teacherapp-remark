// lesson_plan_template_models.dart

import 'package:flutter/cupertino.dart';

class TemplateRecord {
  final int templateId;
  final String className;
  final String subject;
  final String chapter;
  final bool hasTemplate; // show edit/delete only if true

  TemplateRecord({
    required this.templateId,
    required this.className,
    required this.subject,
    required this.chapter,
    required this.hasTemplate,
  });
}

class TemplateHeading {
  final int headingId;
  final String name;
  TemplateHeading({required this.headingId, required this.name});
}

class TemplateFieldData {
  final int headingId;
  final String headingName;
  final TextEditingController controller;
  TemplateFieldData({
    required this.headingId,
    required this.headingName,
    required this.controller,
  });
  void dispose() => controller.dispose();
}