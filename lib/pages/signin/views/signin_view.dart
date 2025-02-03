import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:shongothon/app/data/api/api_service.dart';
import 'package:shongothon/app/routes/app_pages.dart';

import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          Colors.white, // Set to match the Scaffold background color
      statusBarIconBrightness:
          Brightness.dark, // Make the icons dark for a light background
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 400,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome Text
                    Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Please sign in to continue.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 40),
                    // Username Field with Container
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextFormField(
                        controller: controller.usernameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                          hintText: 'Enter your username',
                          prefixIcon: Icon(Icons.person, color: Colors.grey),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.grey[500]), // Hint text color
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Password Field with Container
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextFormField(
                        controller: controller.passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                          hintText: 'Enter your password',
                          prefixIcon: Icon(Icons.lock, color: Colors.grey),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.grey[500]), // Hint text color
                        ),
                        onFieldSubmitted: (_) {
                          _submitForm();
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    // Remember me and Forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => GFCheckbox(
                                size: GFSize.SMALL,
                                activeBgColor: GFColors.PRIMARY,
                                onChanged: (value) {
                                  controller.isChecked.value = value;
                                },
                                value: controller.isChecked.value,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text('Remember me'),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('Forgot Password?'),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    // Sign In Button
                    GFButton(
                      child: Obx(
                        () => controller.isLoading.value
                            ? GFLoader(type: GFLoaderType.ios)
                            : Text('Sign In'),
                      ),
                      onPressed: _submitForm,
                      fullWidthButton: true,
                      color: GFColors.PRIMARY,
                      shape: GFButtonShape.pills,
                      size: GFSize.LARGE,
                    ),
                    SizedBox(height: 30),
                    // Don't have an account? Sign Up Text Button
                    Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.SIGNUP);
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    // Sign in with Phone Button
                    GFButton(
                      onPressed: () {
                        // Action for phone sign-in
                      },
                      text: "Sign in with Phone",
                      icon: Icon(Icons.phone, color: Colors.white),
                      fullWidthButton: true,
                      color: GFColors.SECONDARY,
                      shape: GFButtonShape.pills,
                      size: GFSize.LARGE,
                    ),
                    SizedBox(height: 10),
                    // Sign in with Google Button
                    GFButton(
                      onPressed: () {
                        // Action for Google sign-in
                      },
                      text: "Sign in with Google",
                      icon: Icon(Icons.account_circle, color: Colors.white),
                      fullWidthButton: true,
                      color: GFColors.DANGER,
                      shape: GFButtonShape.pills,
                      size: GFSize.LARGE,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    controller.isLoading.value = true;
    await Get.find<ApiService>()
        .signInWithUsernamePassword(
      controller.usernameController.text.trim(),
      controller.passwordController.text.trim(),
    )
        .then((v) {
      controller.isLoading.value = false;
    });
  }
}
