import 'package:admin_test/firebase_helper/firebase_firestore_helper.dart';
import 'package:admin_test/model/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepository _userRepository = UserRepository();
  var users = <UserModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      isLoading.value = true;
      var fetchedUsers = await _userRepository.fetchUsers();
      users.assignAll(fetchedUsers);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch users');
    } finally {
      isLoading.value = false;
    }
  }
}
