class ComplaintCatModel {
  final String category;

  ComplaintCatModel({required this.category});

  // Factory constructor to create a ComplaintModel from Firestore document
  factory ComplaintCatModel.fromMap(Map<String, dynamic> data) {
    return ComplaintCatModel(
      category: data['category'] ?? '',
    );
  }
}
