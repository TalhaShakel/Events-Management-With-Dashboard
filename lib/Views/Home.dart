import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university/Controller/AuthController.dart';
import 'package:university/Views/Auth/Profile.dart';
import 'package:university/Views/Events/CreateEventScreen.dart';
import 'package:university/Views/Events/ViewEvents.dart';
import 'package:university/Views/Helper.dart';
import 'package:velocity_x/velocity_x.dart';

import '../main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        backgroundColor: themecolor,
        title: Text("${currentuserdata?.name}"),
        actions: [
          GestureDetector(
              onTap: () {
                Get.to(() => ProfileScreen(
                    id: currentuserdata!.id,
                    name: currentuserdata!.name,
                    email: currentuserdata!.email,
                    createdAt: currentuserdata!.createdAt));
              },
              child: Icon(Icons.person))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            20.heightBox,
            Center(
                child: GestureDetector(
                    onTap: () {
                      Get.to(() => CreateEventScreen());
                    },
                    child: Card(
                      color: Colors.transparent,
                      elevation: 7,
                      child: Container(
                          height: Get.height * 0.4,
                          width: Get.width * 0.8,
                          decoration: BoxDecoration(
                              color: themecolor,
                              borderRadius: BorderRadius.circular(16)),
                          child: "Create Event"
                              .text
                              .white
                              .bold
                              .size(28)
                              .makeCentered()),
                    ))),
            // "View Event".text.make(),
            Center(
                child: GestureDetector(
                    onTap: () {
                      Get.to(() => ShowEventsScreen());
                    },
                    child: Card(
                      color: Colors.transparent,
                      elevation: 7,
                      child: Container(
                          height: Get.height * 0.4,
                          width: Get.width * 0.8,
                          decoration: BoxDecoration(
                              color: themecolor,
                              borderRadius: BorderRadius.circular(16)),
                          child: "View Event"
                              .text
                              .white
                              .bold
                              .size(28)
                              .makeCentered()),
                    )))
          ],
        ),
      ),
    );
  }
}
