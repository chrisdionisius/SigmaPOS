import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          iconSize: 30,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.food_bank), label: 'Produk'),
            BottomNavigationBarItem(
                icon: Icon(Icons.timelapse_sharp), label: 'Order'),
            BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on), label: 'Sales'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Setting'),
          ],
          backgroundColor: Colors.white,
          fixedColor: Colors.black,
        ),
      ),
    );
  }
}
