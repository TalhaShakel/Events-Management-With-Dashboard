import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:university/Views/Auth/Login.dart';
import 'package:university/Views/Home.dart';

import '../Models/UserModel.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;
  RxString email = RxString('');
  RxString name = RxString('');

  RxString password = RxString('');
  RxString confirmPassword = RxString('');
  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
  }

  void signUp(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final UserModel user = UserModel(
        id: userCredential.user!.uid,
        name: name.value.toString(),
        email: email,
        createdAt: DateTime.now(),
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(user.toJson());
      print(user.id + "111");

      isLoading.value = false;
      Get.off(() => LoginPage());

      Get.snackbar(
        'Registration Successful',
        'Welcome ${userCredential.user!.email}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } on FirebaseException catch (e) {
      isLoading.value = false;
      print(e.toString());
      Get.snackbar("Error signing in", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      isLoading.value = false;
      print(e.toString());

      Get.snackbar("Error creating account", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void logIn(String email, String password) async {
    try {
      isLoading.value = true;

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .get();
      currentuserdata = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      Get.to(() => HomeScreen());

      isLoading.value = false;

      Get.snackbar(
        'Login Successful',
        'Welcome ${currentuserdata!.email}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } on FirebaseException catch (e) {
      isLoading.value = false;

      Get.snackbar("Error signing in", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      isLoading.value = false;

      Get.snackbar("Error signing in", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void logOut() async {
    await _auth.signOut();
    Get.offAll(() => LoginPage());
  }
}

UserModel? currentuserdata;
