import 'package:admin_test/model/complaint_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ComplaintsViewModel extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var complaints = <ComplaintModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchComplaints();
    super.onInit();
  }

  void fetchComplaints() async {
    try {
      isLoading(true);
      var snapshot = await _firestore.collection('complaints').get();
      complaints.value = snapshot.docs.map((doc) => ComplaintModel.fromMap(doc.id, doc.data())).toList();
    } catch (e) {
      print('Error fetching complaints: $e');
    } finally {
      isLoading(false);
    }
  }
}
