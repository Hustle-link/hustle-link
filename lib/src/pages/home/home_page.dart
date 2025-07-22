import 'package:flutter/material.dart';
import 'package:hustle_link/src/src.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final userController = Get.put<FirebaseAuthService>();
    // final authController = Get.put<AuthController>(AuthController());
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(child: Text('Welcome, ', style: TextStyle(fontSize: 24))),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text('Log Out')),
            const SizedBox(height: 20),
            // links to login and register pages
            ElevatedButton(onPressed: () {}, child: const Text('Login')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () {}, child: const Text('Register')),
          ],
        ),
      ),
    );
  }
}
