
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String urlLogin = "https://api.lyfcon.com/auth/demo/login";
  String urlSignUp = "https://api.lyfcon.com/auth/demo/create-user";
  var box = Hive.box('details');
  Future<http.Response?> loginService(Map<String,dynamic>data,BuildContext context) async {
    print('data-$data');
    print('jsonEncode-${jsonEncode(data)}');
    try {
      http.Response response = await http.post(
        Uri.parse(urlLogin),
        headers: {
          'Content-Type': 'application/json', // Ensures the body is treated as JSON
        },
        body: jsonEncode(data), // Correctly encode the body as a JSON string
      );
      print('response-$response');
      print('statusCode-${response.statusCode}');
      print('statusCode-${response.body}');


      Map<String, dynamic> errorResponse = jsonDecode(response.body);
      String errorMessage = errorResponse['message'] ?? 'An error occurred';

      print('errorResponse');
      print(errorResponse);
      print(errorResponse['statusCode'].runtimeType);
      print(errorMessage);

      if ( errorResponse['statusCode'] != null && errorResponse['statusCode']==400) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Enter Valid Email and Password',textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),backgroundColor: Colors.red),
        );
        print('fbsjkdfbs-${http.Response(errorMessage, errorResponse['statusCode'])}');

        return http.Response(errorMessage, errorResponse['statusCode']);
      }
      else {
        print('body-${response.body}');

        await box.put('first_name', "");
        box.put('last_name', '');
        box.put('email', data['email']);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful',textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),backgroundColor: Colors.green),
        );
        return response;
      }
    } catch (err) {
      print('Exception-$err');
      throw Exception(err);
    }
  }

  Future<http.Response?> createAccountService(Map<String,dynamic> data,BuildContext context) async {
    print('data=$data');
    print('data=${json.encode(data)}');
    // var body = utf8.encode(json.encode(data));
    try {
      http.Response response = await http.post(Uri.parse(urlSignUp),
        headers: {
          'Content-Type': 'application/json', // Ensures the body is treated as JSON
        },
        body: jsonEncode(data), // Correctly encode the body as a JSON string
      );
      print('response-$response');
      print('response-${response.body}');
      print('response-${response.statusCode}');
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registraton Sucessfully',textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),backgroundColor: Colors.green),
        );
        await box.put('first_name', data['firstName']);
        box.put('last_name', data['lastName']);
        box.put('email', data['email']);

        return response;
      }
      else {
        print('else');
        final responseBody = json.decode(response.body);
        print(responseBody);

        final errorMessage = responseBody['message'] ?? 'Unknown error occurred';
        print(errorMessage);
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(errorMessage??"",textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),backgroundColor: Colors.red),
        );
        throw http.Response(errorMessage, response.statusCode, reasonPhrase: response.reasonPhrase);

      }
    } catch (err) {
      print('Exception-$err');
      throw Exception(err);
    }
  }

}

