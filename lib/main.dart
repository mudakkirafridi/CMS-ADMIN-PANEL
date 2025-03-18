// import 'package:flutter/material.dart';

import 'package:admin_test/build_widget.dart';
import 'package:admin_test/firebase_options.dart';
import 'package:admin_test/view_model/complain_controller.dart';
import 'package:admin_test/view_model/complaints_view_model.dart';
import 'package:admin_test/view_model/userController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(AdminPanelApp());
}

class AdminPanelApp extends StatelessWidget {
  const AdminPanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Admin Panel",style: TextStyle(fontWeight: FontWeight.bold),)),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(10),
        children: [
          buildTile(context, "Users", Icons.people, UsersScreen()),
          buildTile(context, "Categories", Icons.category, ComplaintsCategoryScreen()),
          buildTile(context, "Complaints", Icons.report, ComplaintsScreen()),
          buildTile(context, "Reports", Icons.analytics, ReportsScreen()),
          buildTile(context, "Notifications", Icons.notifications, NotificationScreen()),
          buildTile(context, "Settings", Icons.settings, SettingsScreen()),
          buildTile(context, "Assign Complaint", Icons.assignment, AssignComplaintScreen()),
          buildTile(context, "Change Complaint Status", Icons.update, ChangeComplaintStatusScreen()),
          buildTile(context, "View All Complaints", Icons.list, ViewAllComplaintsScreen()),
          buildTile(context, "View All Users", Icons.supervisor_account, ViewAllUsersScreen()),
          buildTile(context, "Block/Unblock Users", Icons.block, BlockUnblockUserScreen()),
          buildTile(context, "View User Complaints", Icons.history, UserComplaintHistoryScreen()),
          buildTile(context, "Manage Categories", Icons.edit, ManageCategoriesScreen()),
          buildTile(context, "Generate Reports", Icons.pie_chart, GenerateReportsScreen()),
          buildTile(context, "Export Reports", Icons.file_download, ExportReportsScreen()),
          buildTile(context, "Send Alerts", Icons.notification_important, SendAlertsScreen()),
          buildTile(context, "Profile Management", Icons.person, ProfileManagementScreen()),
          buildTile(context, "Change Password", Icons.lock, ChangePasswordScreen()),
          buildTile(context, "Edit Admin Profile", Icons.account_circle, EditAdminProfileScreen()),
          buildTile(context, "App Configurations", Icons.tune, AppConfigurationScreen()),
        ],
      ),
    );
  }

  
  }



class ComplaintsScreen extends StatelessWidget {
  final ComplaintsViewModel controller = Get.put(ComplaintsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Complaints')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.complaints.isEmpty) {
          return Center(child: Text('No complaints found'));
        }
        return ListView.builder(
          itemCount: controller.complaints.length,
          itemBuilder: (context, index) {
            final complaint = controller.complaints[index];
            return Card(
              child: ListTile(
                title: Text(complaint.title),
                subtitle: Text(complaint.description),
                trailing: Text(complaint.status.isEmpty ? 'Pending' : complaint.status),
              ),
            );
          },
        );
      }),
    );
  }
}




class UsersScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users List')),
      body: Obx(() {
        if (userController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (userController.users.isEmpty) {
          return Center(child: Text('No users found'));
        }
        return ListView.builder(
          itemCount: userController.users.length,
          itemBuilder: (context, index) {
            var user = userController.users[index];
            return ListTile(
              title: Text(user.fullName),
              subtitle: Text(user.email),
              trailing: Text(user.academicLevel),
            );
          },
        );
      }),
    );
  }
}


class ComplaintsCategoryScreen extends StatelessWidget {
  final ComplaintController controller = Get.put(ComplaintController());

  @override
  Widget build(BuildContext context) {
    controller.fetchUniqueCategoriesOnce(); // Fetch complaints when the screen loads

    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: Obx(() {
        if (controller.categories.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(controller.categories[index].category),
            );
          },
        );
      }),
    );
  }
}


class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Reports & Analytics")), body: Center(child: Text("View Reports Here")));
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Notifications")), body: Center(child: Text("Send Notifications Here")));
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Settings")), body: Center(child: Text("Manage Settings Here")));
  }
}

class ViewAllComplaintsScreen extends StatelessWidget {
  const ViewAllComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View All Complaints")),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: EdgeInsets.all(10),
        itemCount: 10, // Replace with actual number of complaints
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.report, size: 50, color: Colors.green),
                SizedBox(height: 10),
                Text("Complaint #$index", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("View complaint details", style: TextStyle(fontSize: 14)),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle the action to view complaint details
                  },
                  child: Text("View Details"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AssignComplaintScreen extends StatelessWidget {
  const AssignComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Assign Complaints")),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: EdgeInsets.all(10),
        itemCount: 10, // Replace this with your actual data count
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.assignment, size: 50, color: Colors.green),
                SizedBox(height: 10),
                Text("Complaint #$index", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Assign this complaint", style: TextStyle(fontSize: 14)),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle assignment action
                  },
                  child: Text("Assign"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ChangeComplaintStatusScreen extends StatelessWidget {
  const ChangeComplaintStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Change Complaint Status")), body: Center(child: Text("Change the complaint status")));
  }
}

class ViewAllUsersScreen extends StatelessWidget {
  const ViewAllUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("View All Users")), body: Center(child: Text("View all registered users")));
  }
}

class BlockUnblockUserScreen extends StatelessWidget {
  const BlockUnblockUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Block/Unblock Users")), body: Center(child: Text("Manage user blocking/unblocking")));
  }
}

class UserComplaintHistoryScreen extends StatelessWidget {
  const UserComplaintHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("User Complaint History")), body: Center(child: Text("View user complaint history")));
  }
}

class ManageCategoriesScreen extends StatelessWidget {
  const ManageCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Manage Categories")), body: Center(child: Text("Manage complaint categories")));
  }
}

class GenerateReportsScreen extends StatelessWidget {
  const GenerateReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Generate Reports")), body: Center(child: Text("Generate various reports")));
  }
}

class ExportReportsScreen extends StatelessWidget {
  const ExportReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Export Reports")), body: Center(child: Text("Export reports to different formats")));
  }
}

class SendAlertsScreen extends StatelessWidget {
  const SendAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Send Alerts")), body: Center(child: Text("Send alerts to users")));
  }
}

class ProfileManagementScreen extends StatelessWidget {
  const ProfileManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Profile Management")), body: Center(child: Text("Manage your profile")));
  }
}

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Change Password")), body: Center(child: Text("Change your account password")));
  }
}

class EditAdminProfileScreen extends StatelessWidget {
  const EditAdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Edit Admin Profile")), body: Center(child: Text("Edit the admin profile")));
  }
}

class AppConfigurationScreen extends StatelessWidget {
  const AppConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("App Configuration")), body: Center(child: Text("App configuration settings")));
  }
}
