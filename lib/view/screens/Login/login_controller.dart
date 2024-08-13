import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../../AuthService/auth_service.dart';
import '../bottom_navigationbar/bottom_navigation_bar.dart';
import '../bottom_navigationbar/home_screen.dart';

class AuthController extends GetxController {
  final AuthService authService = AuthService();

  Future<void> login(String email, String password,BuildContext context) async {
    var box = Hive.box('details');
    final Map<String,dynamic> data = {
      "email":email,
      "password":password,
    };

    final response = await authService.loginService(data, context);
    print('response!.statusCode');
    print(response!.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      // Handle successful login
      print("Login successful: ${response.body}");
       Navigator.pushReplacement(
        context,
             MaterialPageRoute(builder: (context) =>  BottomNavigation()),
      );


    }
    else {
      // Handle error
      print("Login failed: ${response!.body}");
    }
  }
}
