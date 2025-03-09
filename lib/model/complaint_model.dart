class ComplaintModel {
  final String id;
  final String category;
  final String description;
  final String level3Category;
  final String status;
  final String subCategory;
  final DateTime timestamp;
  final String title;

  ComplaintModel({
    required this.id,
    required this.category,
    required this.description,
    required this.level3Category,
    required this.status,
    required this.subCategory,
    required this.timestamp,
    required this.title,
  });

  factory ComplaintModel.fromMap(String id, Map<String, dynamic> map) {
    return ComplaintModel(
      id: id,
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      level3Category: map['level3Category'] ?? '',
      status: map['status'] ?? '',
      subCategory: map['subCategory'] ?? '',
      timestamp: DateTime.parse(map['timestamp'] ?? DateTime.now().toIso8601String()),
      title: map['title'] ?? '',
    );
  }
}
