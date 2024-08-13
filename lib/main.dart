import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meji_task_new/view/screens/Login/login_screen.dart';
import 'package:meji_task_new/view/screens/bottom_navigationbar/bottom_navigation_bar.dart';
Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox<String>('my_box');
  await Hive.openBox('details');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('details');

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: box.get('email') == null || box.get('email').toString().isEmpty
      ? LoginScreen()
      :BottomNavigation(),
    );
  }
}