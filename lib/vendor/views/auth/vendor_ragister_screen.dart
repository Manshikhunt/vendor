import 'dart:typed_data';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/vendor/controllers/vendor_ragister_controller.dart';
import 'package:vendor/vendor/views/auth/login_screen.dart';

class VendorRagisterScreen extends StatefulWidget {
  const VendorRagisterScreen({super.key});

  @override
  State<VendorRagisterScreen> createState() => _VendorRagisterScreenState();
}

class _VendorRagisterScreenState extends State<VendorRagisterScreen> {
  final VenderController _venderController = VenderController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String businesName;
  late String email;
  late String phoneNumber;
  late String countryValue;
  late String stateValue;
  late String cityValue;
  late String taxRagisterd;
  String? taxNumber = '';

  Uint8List? _image;

  selectGallaryImage() async {
    Uint8List im = await _venderController.pickStoreImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  selectCameraImage() async {
    Uint8List im = await _venderController.pickStoreImage(ImageSource.camera);

    setState(() {
      _image = im;
    });
  }

  String? _textStatus;
  final List<String> _textOptions = ['Yes', 'No'];

  _saveVendorDetail() async {
    EasyLoading.show(status: 'Please Wait');
    if (_textStatus == 'No'){
    taxNumber = '';
  }
    if (_formkey.currentState!.validate()) {
      await _venderController
          .ragisterVendor(businesName, email, phoneNumber, countryValue,
              stateValue, cityValue, _textStatus!, taxNumber!, _image)
          .whenComplete(() {
        EasyLoading.dismiss();

        setState(() {
          _formkey.currentState!.reset();
          _image = null;
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context){
              return LoginScreen();
            }));
        });
      });
      print('done');
      print(_auth.currentUser!.uid);
    } else {
      print('bad');
      EasyLoading.dismiss();
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 224, 216),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 200,
            flexibleSpace: LayoutBuilder(
              builder: (context, Constraints) {
                return FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.green.shade200,
                          Colors.green.shade100,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Center(
                                  child: Expanded(
                                    child: _image != null
                                        ? Image.memory(
                                            _image!,
                                            fit: BoxFit.cover,
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              selectGallaryImage();
                                            },
                                            icon: const Icon(CupertinoIcons.photo),
                                          ),
                                  ),
                                ),
                                Positioned(
                                  bottom: -18,
                                  right: -18,
                                  child: IconButton(
                                    onPressed: () {
                                      selectCameraImage();
                                    },
                                    icon: const Icon(CupertinoIcons.camera),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) {
                        businesName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Business Name cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Business Name',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email Address cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone Number cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.phone_android),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectState(
                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            stateValue = value;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            cityValue = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            'Text Rgistered:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: SizedBox(
                              width: 100,
                              child: DropdownButtonFormField(
                                  hint: const Text(
                                    'Select',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  items: _textOptions
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _textStatus = value;
                                    });
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (_textStatus == 'Yes')
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            taxNumber = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Tax Number cannot be empty';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Enter Tax Number',
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        _saveVendorDetail();
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: Colors.green.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Save',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
