import 'package:flutter/material.dart';

import '../data/services/firestore_service.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: height * 0.2,
            width: width,
            child: Center(
              child: Image.asset(
                'assets/images/sigma.png',
                width: width * 0.5,
              ),
            ),
          ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
            onTap: () async {
              // Get.reset();
              await signOut();
            },
          ),
        ],
      ),
    );
  }
}
