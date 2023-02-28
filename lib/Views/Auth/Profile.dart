import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university/Controller/AuthController.dart';
import 'package:university/Controller/EventController.dart';
import 'package:university/Views/Helper.dart';

class ProfileScreen extends StatelessWidget {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;

  const ProfileScreen({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final AuthController _eventController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themecolor,
        title: Text('Profile'),
        actions: [
          GestureDetector(
              onTap: () {
                _eventController.logOut();
              },
              child: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Email:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8),
            Text(
              email,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'ID:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8),
            Text(
              id,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Account Created:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8),
            Text(
              createdAt.toString(),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
