import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:university/Controller/AuthController.dart';

import 'Models/UserModel.dart';
import 'Views/Auth/Login.dart';
import 'Views/Home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AuthController controller = Get.put(AuthController());

  if (FirebaseAuth.instance.currentUser != null) {
    await getUserData(FirebaseAuth.instance.currentUser!.uid);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  check(snapshot) {
    setState(() {
      getUserData(snapshot.data!.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            getUserData(snapshot.data!.uid);

            // setState(() {});
          }
          // print(snapshot.data?.uid);
          // userData = UserModel.fromMap(snapshot.data as Map<String, dynamic>);
          return snapshot.hasData ? HomeScreen() : LoginPage();
        }
      },
    );
  }
}

getUserData(String uid) async {
  try {
    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
    final userDoc = await userRef.get();
    final userData1 = userDoc.data();
    if (userData1 != null) {
      // final name = userData['name'] as String;
      // final email = userData['email'] as String;

      currentuserdata = UserModel.fromJson(userData1 as Map<String, dynamic>);
      // return UserModel(uid: uid, name: name, email: email);
    } else {
      throw Exception('User data not found');
    }
  } catch (e) {
    print(e.toString());
  }
}
