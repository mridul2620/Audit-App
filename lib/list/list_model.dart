class Audit {
  final String auditType;
  final String categoryImage;
  final String auditDate;
  final String status;
  final String schoolName;

  Audit({
    required this.auditType,
    required this.categoryImage,
    required this.auditDate,
    required this.status,
    required this.schoolName,
  });

  factory Audit.fromJson(Map<String, dynamic> json) {
    return Audit(
      auditType: json['audit_type'],
      categoryImage: json['category_image'],
      auditDate: json['audit_date'],
      status: json['status'],
      schoolName: json['school_name'],
    );
  }
}