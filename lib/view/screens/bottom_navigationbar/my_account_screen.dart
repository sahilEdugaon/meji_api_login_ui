import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../utils/colors_constant.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_container_widgets.dart';
import '../Login/login_screen.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {

  TextEditingController firstNameController = TextEditingController(text: 'John');
  TextEditingController lastNameController = TextEditingController(text: 'Doe');
  TextEditingController emailController = TextEditingController(text: 'johndoe@gmail.com');

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the widget tree
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var finalHeight = MediaQuery.of(context).size.height;
    var finalWidth = MediaQuery.of(context).size.width;
    var box = Hive.box('details');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Image.asset("assets/images/meui_logo.png", height: finalHeight/11,),
        shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
      ),

      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("My Profile", style: TextStyle(color: ColorsConstant.buttonColor, fontSize: finalHeight/35, fontWeight: FontWeight.bold),),

                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: CustomContainerTextField(
                    controller: firstNameController,
                    suffixIcon: Icon(Icons.visibility),
                    labelTexts: "First Name",
                    leftBorderColor: ColorsConstant.buttonColor, // Set the left border color here
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: CustomContainerTextField(
                    controller: lastNameController,
                    suffixIcon: Icon(Icons.visibility),
                    labelTexts: "Last Name",
                    leftBorderColor: ColorsConstant.buttonColor, // Set the left border color here
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 40),
                  child: CustomContainerTextField(
                    controller: emailController,
                    suffixIcon: Icon(Icons.visibility),
                    labelTexts: "Email Address",
                    leftBorderColor: ColorsConstant.buttonColor, // Set the left border color here
                  ),
                ),

                CustomButton(text: "UPDATE MY ACCOUNT",
                  onPressed: () {

                  },
                ),

                SizedBox(height: finalHeight/30,),
                CustomButton(text: "LOGOUT",
                  onPressed: () async {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
                    await box.clear();
                  },
                ),

              ],
            ),
          )
        ],
      ),



    );
  }
}