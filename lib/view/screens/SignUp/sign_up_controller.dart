import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../AuthService/auth_service.dart';
import '../bottom_navigationbar/bottom_navigation_bar.dart';
class SignupController extends GetxController {
  var isLoading = false.obs;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();



  // Method to perform signup
  void signup(BuildContext context) async {
    if(firstNameController.text.isEmpty || lastNameController.text.isEmpty ||
        emailController.text.isEmpty || passwordController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please Enter All Filed',textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),backgroundColor: Colors.red),
      );
    }
    else if(!EmailValidator.validate(emailController.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please Enter valid Email',textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),backgroundColor: Colors.red),
      );
    }
    else if(passwordController.text.length < 6 ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters',textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),backgroundColor: Colors.red),
      );
    }
    else  {
      isLoading(true); // Start loading indicator
      try {
       // Here you can call your signup service
        Example:

        final Map<String,dynamic> data = {
          "firstName":firstNameController.text.trim(),
          "lastName":lastNameController.text.trim(),
          "email":emailController.text.trim(),
          "password":passwordController.text.trim(),
        };

        final response = await AuthService().createAccountService(data, context);
        print('response!.statusCode');
        print(response!.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          // Handle successful login
          print("Create Users successful: ${response.body}");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavigation()),
          );
          isLoading(false); // Start loadin

          firstNameController.clear();
          lastNameController.clear();
          emailController.clear();
          passwordController.clear();
        }
        else {
          // Handle error
          print("Login failed: ${response!.body}");
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to signup',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading(false); // Stop loading indicator
      }
    }
  }
}
