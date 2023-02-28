import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/UniversityModel.dart';
import '../Views/Home.dart';

class EventController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final RxList<Event> events = <Event>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Load the events from Firestore when the controller is initialized
    loadEvents();
  }

  Future<void> loadEvents() async {
    try {
      isLoading.value = true;
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _db.collection('events').get();

      final List<Event> loadedEvents =
          querySnapshot.docs.map((doc) => Event.fromJson(doc.data())).toList();

      events.value = loadedEvents;
      hasError.value = false;
    } catch (e) {
      // If there's an exception, set the error flag to true
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createEvent(Event event,context) async {
    try {
      await _db.collection('events').add(event.toJson(context));
      Get.snackbar(
        'Success',
        'Event created successfully!',
        duration: Duration(seconds: 3),
      );
      Get.offAll(() => HomeScreen());
    } catch (e) {
      // If there's an exception, show a snackbar with the error message
      print(e.toString());
      Get.snackbar(
        'Error',
        'Failed to create event: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
