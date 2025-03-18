import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../model/complaint_model.dart';

class ComplaintStatusControllerView extends GetxController {


@override
  void onInit() {
    fetchComplaints();
    super.onInit();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var complaints = <ComplaintModel>[].obs; // Observable list

  // Fetch all complaints from Firestore
  Future<void> fetchComplaints() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('complaints').get();

      complaints.value = querySnapshot.docs.map((doc) {
        return ComplaintModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Error fetching complaints: $e");
    }
  }

  // Update Complaint Status
  Future<void> updateComplaintStatus(String complaintId, String newStatus) async {
    try {
      await _firestore.collection('complaints').doc(complaintId).update({'status': newStatus});

      // Update locally
      int index = complaints.indexWhere((complaint) => complaint.id == complaintId);
      if (index != -1) {
        complaints[index] = ComplaintModel(
          id: complaints[index].id,
          category: complaints[index].category,
          subCategory: complaints[index].subCategory,
          level3Category: complaints[index].level3Category,
          title: complaints[index].title,
          description: complaints[index].description,
          status: newStatus, // Updated status
          timestamp: complaints[index].timestamp,
        );
        complaints.refresh(); // Refresh UI
      }
    } catch (e) {
      print("Error updating complaint status: $e");
    }
  }
}
