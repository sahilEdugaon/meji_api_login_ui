import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meji_task_new/view/screens/bottom_navigationbar/place_an_ad_screen.dart';

import '../../../utils/colors_constant.dart';
import 'cart_screen.dart';
import 'home_screen.dart';
import 'my_account_screen.dart';
import 'myorders_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedPageIndex = 0;
  bool _showBottomNav = true;
  bool _isScrollingDown = false;
  late ScrollController _scrollController;

  late List<Widget> screens;



  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    screens = [
      HomeScreen(scrollController: _scrollController),
      const MyOrdersScreen(),
      const PlaceAnAdScreen(),
      const CartScreen(),
      const MyAccountScreen()
    ];
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!_isScrollingDown) {
        setState(() {
          _isScrollingDown = true;
          _showBottomNav = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (_isScrollingDown) {
        setState(() {
          _isScrollingDown = false;
          _showBottomNav = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'home',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: screens[selectedPageIndex],
        bottomNavigationBar: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _showBottomNav ? kBottomNavigationBarHeight : 0.0,
          child: Wrap(
            children: [
              BottomNavigationBar(
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                mouseCursor: SystemMouseCursors.allScroll,
                selectedItemColor: ColorsConstant.buttonColor,
                selectedFontSize: 10,
                unselectedFontSize: 10,
                backgroundColor: Colors.white,
                unselectedItemColor: ColorsConstant.buttonColor,
                currentIndex: selectedPageIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",

                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.fact_check_outlined),
                    label: "My Orders",
                  ),

                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle),
                    label: "Place an ad",
                  ),

                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: "Cart",
                  ),

                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "My Account",
                  ),
                ],
                onTap: (index) {
                  selectedPageIndex = index;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
