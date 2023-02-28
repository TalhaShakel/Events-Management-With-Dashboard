import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university/Controller/AuthController.dart';
import 'package:university/Views/Auth/RegisterScreen.dart';
import 'package:university/Views/Helper.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthController authService = Get.find<AuthController>();

    return Scaffold(
      // appBar: AppBar(title: Text('Login Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.0),

              Center(child: "Login".text.bold.size(41).make()),
              // SizedBox(height: 16.0),
              SizedBox(height: 80.0),

              "Email Address".text.bold.make(),
              SizedBox(height: 5.0),

              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email cannot be empty';
                  } else if (!GetUtils.isEmail(value)) {
                    return 'Invalid email format';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16.0),
              "Password".text.bold.make(),
              SizedBox(height: 5.0),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password cannot be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
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
                        onTap: authService.isLoading.value
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  // perform login logic here
                                  String email = emailController.text.trim();
                                  String password =
                                      passwordController.text.trim();
                                  authService.logIn(email, password);
                                }
                              },
                        child: authService.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: 'Login'
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
              // ElevatedButton(
              //   onPressed: () {
              //     if (_formKey.currentState!.validate()) {
              //       // perform login logic here
              //       String email = emailController.text.trim();
              //       String password = passwordController.text.trim();
              //       authService.logIn(email, password);
              //     }
              //   },
              //   child: Text('Login'),
              // ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: () {
                      Get.to(() => RegisterView());
                    },
                    child: "Register".text.color(themecolor).make()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
