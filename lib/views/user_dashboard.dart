 import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  String _userName = "User";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
      try {
    final email = await AuthService().getCurrentUserEmail();
    debugPrint(" Logged-in Email: $email");

    if (email != null) {
      final users = await UserService().getAllUsers();
      debugPrint("📄 All Users from DB: $users");

      final user = users.firstWhere(
        (u) => u['email'] == email,
        orElse: () => {'name': 'User'},
      );

      debugPrint(" Matched user: $user");

      setState(() {
        _userName = user['name'] ?? "User";
        _isLoading = false;
      });
    } else {
      debugPrint(" Email is null");
      setState(() => _isLoading = false);
    }
  } catch (e) {
    debugPrint(" Error in loadUserName: $e");
    setState(() {
      _userName = "User";
      _isLoading = false;
    });
   }
  }

  void _logout() async {
    await AuthService().signOutUser();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Dashboard"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.verified_user, size: 100, color: Colors.deepPurple),
                    const SizedBox(height: 20),
                    Text(
                      "Welcome, $_userName 👋",
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "You are now logged in!",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.logout),
                      label: const Text("Logout"),
                      onPressed: _logout,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
