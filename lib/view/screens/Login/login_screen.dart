import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../utils/colors_constant.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../custom_widgets/under_line_textbutton.dart';
import '../SignUp/signup_screen.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var finalHeight = MediaQuery.of(context).size.height;
    var finalWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(height: finalHeight/5,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: CustomText(text: "Welcome To", style: TextStyle(color: ColorsConstant.textGreenColor, fontWeight: FontWeight.bold, fontSize: finalHeight/35),)),
                Center(child: Image.asset("assets/images/meui_logo.png", height: finalHeight/6,)),
                CustomTextField(labelText: "Email Address",controller: emailController),
                SizedBox(height: finalHeight/50,),
                CustomTextField(
                  labelText: "Password",controller:passwordController ,
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: finalHeight/20,),
                CustomButton(
                  text: "LOGIN",
                  onPressed: () {

                    if(emailController.text.trim().isEmpty && passwordController.text.trim().isEmpty ){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a valid email and Password',textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),backgroundColor: Colors.red),
                      );
                    }
                    // Validate email
                    else if (emailController.text.trim().isEmpty || !EmailValidator.validate(emailController.text.trim())) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a valid email',textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),backgroundColor: Colors.red),
                      );
                    }
                    else if(passwordController.text.trim().isEmpty) {
                      // If email is valid, perform login
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a Password',textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),backgroundColor: Colors.red),
                      );
                    }
                    else{
                      authController.login(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          context
                      ).then((value) {
                        emailController.clear();
                        passwordController.clear();
                      });

                      // Navigate to HomePage after successful login

                    }
                  },
                ),
                SizedBox(height: finalHeight/90,),
                UnderlineTextButton(text: "Create new account", onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                },)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
