import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendor/vendor/views/auth/login_screen.dart';

class MainVendorScreen extends StatelessWidget {
  const MainVendorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen())
            );
          },
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
