import 'package:admin_app_ecommerce/screen/navbar/category_page.dart';
import 'package:admin_app_ecommerce/screen/navbar/home_page.dart';
import 'package:admin_app_ecommerce/screen/navbar/order_page.dart';
import 'package:admin_app_ecommerce/screen/navbar/product_page.dart';
import 'package:flutter/material.dart';

import 'profile_page.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({Key? key}) : super(key: key);

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  List<Widget> pages=[
    HomePage(),
    CategoryPage(),
    ProductPage(),
    OrderPage(),
    ProfilePage(),
  ];
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: pages[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white70,

        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.blue,

        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category),label: "Categrory"),
          BottomNavigationBarItem(icon: Icon(Icons.radar),label: "Product"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Order"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),


        ],
      ),
    );
  }
}
