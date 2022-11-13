import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/modules/setting/setting_controller.dart';
import 'package:sigma_pos/app/widget/bottom_navbar.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingController controller = Get.put(SettingController());
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        title: const Text(
          'Setting',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            Icons.sort,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: controller.listMenu.map((e) {
              return Column(
                children: [
                  InkWell(
                    onTap: () => Get.toNamed(e.route!),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          IconData(e.icon!, fontFamily: 'MaterialIcons'),
                          size: width * 0.25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Text(e.name!),
                ],
              );
            }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: const UserBottomNavbar(choosenIndex: 3),
    );
  }
}
