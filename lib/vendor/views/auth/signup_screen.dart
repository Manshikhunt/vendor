import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/utils/show_snackbar.dart';
import 'package:vendor/vendor/controllers/vendor_ragister_controller.dart';
import 'package:vendor/vendor/views/auth/login_screen.dart';
import 'package:vendor/vendor/views/auth/vendor_ragister_screen.dart';

class RagisterScreen extends StatefulWidget {
  const RagisterScreen({super.key});

  @override
  State<RagisterScreen> createState() => _RagisterScreenState();
}

class _RagisterScreenState extends State<RagisterScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final List _bannerImages = [];
  final VenderController _authController = VenderController();

  late String email;
  late String fullName;
  late String phoneNumber;
  late String password;

  bool _isLoading = false;

  Uint8List? _image;

  _signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    if (_formkey.currentState!.validate()) {
      await _authController
          .signUpUser(email, fullName, phoneNumber, password, _image)
          .whenComplete(() {
        setState(() {
          _formkey.currentState!.reset();
          _image = null;
          _isLoading = false;
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context){
              return VendorRagisterScreen();
            }));
        });
      });

      return showSnack(
          context, 'Vendor is ragister successfully!', Colors.green.shade700);
    } else {
      _isLoading = false;
      return showSnack(
          context, 'All fields must be required', Colors.red.shade700);
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

  selectGalleryImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  selectCameraImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.camera);

    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 224, 216),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Stack(
                children: [
                  _bannerImages.isNotEmpty
                      ? ClipPath(
                          clipper: LiberalCurveClipper(),
                          child: Image.network(
                            _bannerImages[8],
                            width: MediaQuery.of(context).size.width,
                            height: 300, // Adjust height as needed
                            fit: BoxFit.cover,
                          ),
                        )
                      : const CircularProgressIndicator(),
                  Positioned(
                    top: 180,
                    right: 25,
                    child: _image != null
                    ? CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage: MemoryImage(_image!),
                    )
                    :CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      //backgroundImage: NetworkImage('https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'),
                      child: IconButton(
                        onPressed: (){
                          selectGalleryImage();
                        }, 
                        icon: Icon(
                          _image == null
                          ? CupertinoIcons.photo
                          : null,
                          color: Colors.grey,),),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ragistration',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 24, 101, 26),
                        letterSpacing: 1,
                      ),
                    ),
                    const Text(
                      'Create Vendor"s account',
                      style: TextStyle(
                        color: Color.fromARGB(255, 15, 87, 18),
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                        labelText: 'user@mail.com',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Full Name cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        fullName = value;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.person),
                        labelText: 'Enter your full name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Mobile Number cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.phone_android),
                        labelText: 'Enter your phone number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                        labelText: 'password',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        _signUpUser();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.5,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const LoginScreen();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.green[500]),
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
    );
  }
}

class LiberalCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.85); 

    var firstControlPoint = Offset(size.width / 4, size.height * 0.85);
    var firstEndPoint = Offset(size.width / 2, size.height * 0.75);

    var secondControlPoint = Offset(size.width * 3 / 4, size.height * 0.65);
    var secondEndPoint = Offset(size.width, size.height * 0.75);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0); 
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}




