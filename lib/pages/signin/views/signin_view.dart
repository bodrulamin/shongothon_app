import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:shongothon/app/data/auth_service.dart';
import 'package:shongothon/app/routes/app_pages.dart';

import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
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
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    // Username Field
                    TextFormField(
                      controller: controller.usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red, width: 3),
                        ),
                        contentPadding: EdgeInsets.only(left: 30),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Password Field
                    TextFormField(
                      controller: controller.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red, width: 3),
                        ),
                        contentPadding: EdgeInsets.only(left: 30),
                      ),
                      // Trigger Sign In on Enter press
                      onFieldSubmitted: (_) {
                        _submitForm();
                      },
                    ),
                    SizedBox(height: 20),
                    // Sign In Button
                    GFButton(
                      child: Obx(
                            () => controller.isLoading.value
                            ? GFLoader(type: GFLoaderType.ios)
                            : Text('Sign In'),
                      ),
                      onPressed: () {
                        _submitForm();
                      },
                      fullWidthButton: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Obx(
                                  () => GFCheckbox(
                                size: GFSize.SMALL,
                                activeBgColor: GFColors.DANGER,
                                onChanged: (value) {
                                  controller.isChecked.value = value;
                                },
                                value: controller.isChecked.value,
                              ),
                            ),
                            Text('Remember me'),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('Forgot Password'),
                        ),
                      ],
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
      controller.usernameController.text.toString(),
      controller.passwordController.text.toString(),
    )
        .then((v) {
      controller.isLoading.value = false;
    });
  }
}
