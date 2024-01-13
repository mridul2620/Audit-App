class ReworkCategoryModel {
  final int auditId;
  final int userId;
  final String auditName;
  final int categoryId;
  final String address;
  final String auditDate;
  final int totalQues;
  final int pendingQues;
  final int completedQues;
  final String status;
  final String categoryName;
  final String categoryImage;

  ReworkCategoryModel(
      {required this.auditId,
      required this.userId,
      required this.auditName,
      required this.categoryId,
      required this.categoryImage,
      required this.categoryName,
      required this.address,
      required this.totalQues,
      required this.pendingQues,
      required this.completedQues,
      required this.status,
      required this.auditDate});
}
