import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor/utils/show_snackbar.dart';
import 'package:vendor/vendor/controllers/vendor_ragister_controller.dart';
import 'package:vendor/vendor/views/auth/signup_screen.dart';
import 'package:vendor/vendor/views/auth/vendor_ragister_screen.dart';
import 'package:vendor/vendor/views/screens/landing_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List _bannerImages = [];
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final VenderController _authController = VenderController();

  late String email;
  late String password;

  bool _isLoading = false;

  _loginUsers() async {
    setState(() {
      _isLoading = true;
    });
    if (_formkey.currentState!.validate()) {
      String res =  await _authController.loginUsers(email, password);

      if(res == 'success'){
        return Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext content) {
          return LandingScreen();
          //return const VendorRagisterScreen();
        }));
      }else{
        return showSnack(context, res, Colors.red.shade700);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnack(
          context, 'Fields must not be empty', Colors.red.shade700);
    }
  }

  getbanner() {
    return _firestore
        .collection('banners')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _bannerImages.add(doc['image']);
        });
      }
    });
  }

  @override
  void initState() {
    getbanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Stack(
          children: [
            // Background Image
            _bannerImages.isNotEmpty
                ? Image.network(
                    _bannerImages[8],
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  )
                : Container(
                    color: Colors.green,
                  ),
            // Semi-transparent overlay
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
            // Login form
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Login Vendor"s Account',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[200],
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email cannot be empty';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.email),
                              labelText: 'Enter email address',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password cannot be empty';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.lock),
                              labelText: 'Enter password',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              _loginUsers();
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.green[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child:  _isLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Need an account?',
                                style: TextStyle(color: Colors.black),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const RagisterScreen();
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(color: Colors.green[200]),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
