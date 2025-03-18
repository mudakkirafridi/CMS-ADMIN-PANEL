import 'package:admin_test/model/cateogory_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ComplaintController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var categories = <ComplaintCatModel>[].obs;
  var isFetched = false.obs; // Flag to track if data is already fetched

  // Fetch unique categories from Firestore only once
  Future<void> fetchUniqueCategoriesOnce() async {
    if (isFetched.value) return; // Stop if already fetched

    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('complaints').get();

      // Use a Set to store unique category values
      Set<String> uniqueCategories = {};

      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        String category = data['category'] ?? '';
        if (category.isNotEmpty) {
          uniqueCategories.add(category);
        }
      }

      // Convert to ComplaintCatModel list
      categories.value =
          uniqueCategories.map((cat) => ComplaintCatModel(category: cat)).toList();
      
      isFetched.value = true; // Mark as fetched
    } catch (e) {
      print("Error fetching unique categories: $e");
    }
  }
}
