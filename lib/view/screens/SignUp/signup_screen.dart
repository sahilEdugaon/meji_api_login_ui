import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meji_task_new/view/screens/SignUp/sign_up_controller.dart';
import '../../../utils/colors_constant.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text.dart';
import '../../custom_widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}
final SignupController signupController = Get.put(SignupController());

class _SignupScreenState extends State<SignupScreen> {


  @override
  void dispose() {
    signupController.emailController.clear();
    signupController.passwordController.clear();
    signupController.firstNameController.clear();
    signupController.lastNameController.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var finalHeight = MediaQuery.of(context).size.height;
    var finalWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: finalHeight/20,),
                Center(child: Image.asset("assets/images/meui_logo.png", height: finalHeight/4,)),

                Center(child: FittedBox(child: CustomText(text: "Sign Up With Your Email Address", style: TextStyle(color: ColorsConstant.textGreenColor, fontWeight: FontWeight.bold, fontSize: finalHeight/35),))),
                SizedBox(height: finalHeight/50,),
                CustomTextField(labelText: "First Name",controller:signupController.firstNameController ),
                SizedBox(height: finalHeight/50,),
                CustomTextField(
                  labelText: "Last Name",
                 controller: signupController.lastNameController,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: finalHeight/50,),
                CustomTextField(
                  labelText: "Email Address",
                  controller: signupController.emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: finalHeight/50,),
                CustomTextField(
                  labelText: "Password",
                  controller: signupController.passwordController,
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: finalHeight/30,),
                CustomButton(text: "CREATE ACCOUNT",
                  onPressed: () {
                    signupController.signup(context);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigation()));
                },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
