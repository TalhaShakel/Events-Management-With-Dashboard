import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university/Controller/AuthController.dart';
import 'package:university/Views/Auth/Login.dart';
import 'package:university/Views/Helper.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterView extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Register'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.0),

                Center(child: "Register".text.bold.size(41).make()),
                // SizedBox(height: 16.0),
                SizedBox(height: 80.0),
                "User Name".text.bold.make(),
                SizedBox(height: 5.0),

                TextFormField(
                  onChanged: (value) {
                    controller.name.value = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email cannot be Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                "Email Address".text.bold.make(),
                SizedBox(height: 5.0),

                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    controller.email.value = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email';
                    } else if (!GetUtils.isEmail(value)) {
                      return 'Invalid email format';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                "Password".text.bold.make(),
                SizedBox(height: 5.0),

                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                  onChanged: (value) {
                    controller.password.value = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password should be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                "Confirm Password".text.bold.make(),
                SizedBox(height: 5.0),

                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Confirm Password',
                  ),
                  onChanged: (value) {
                    controller.confirmPassword.value = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != controller.password.value) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32),
                Obx(
                  () => Center(
                    child: Card(
                      color: Colors.transparent,
                      elevation: 8,
                      child: Container(
                        // elevation: 5,
                        height: 40,
                        width: Get.width * 0.8,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(27, 46, 79, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: GestureDetector(
                          onTap: controller.isLoading.value
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    controller.signUp(controller.email.value,
                                        controller.password.value);
                                  }
                                },
                          child: controller.isLoading.value
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: 'Register'
                                      .text
                                      .center
                                      .white
                                      .size(21)
                                      .bold
                                      .make(),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () {
                        Get.to(() => LoginPage());
                      },
                      child: "Login".text.color(themecolor).make()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
