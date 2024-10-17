import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendor/vendor/models/vendor_user_model.dart';
import 'package:vendor/vendor/views/auth/signup_screen.dart';
import 'package:vendor/vendor/views/screens/main_vendor_screen.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _vendorStream =
      FirebaseFirestore.instance.collection('vendors');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: _vendorStream.doc(_auth.currentUser!.uid).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          if(!snapshot.data!.exists){
            return const RagisterScreen();
          }

          VendorUserModel vendorUserModel = VendorUserModel.fromJson(
              snapshot.data!.data()! as Map<String, dynamic>);

          if(vendorUserModel.approved == true){
            return const MainVendorScreen();
          }

          return Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    vendorUserModel.storageImage.toString(),
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 15,),
                Text(
                  vendorUserModel.businesName.toString(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10,),
                const Text('Your application has been sent to admin. Admin will get back to you soon',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10,),
                TextButton(onPressed: () async{
                  await _auth.signOut();
                }, child: const Text('Sign Out'),),
              ],
            ),
          );
        },
      ),
    );
  }
}


//flutter run -d chrome --web-renderer html