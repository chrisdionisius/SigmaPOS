import 'package:flutter/material.dart';
import 'package:sigma_pos/app/widget/main_button.dart';

import '../../data/services/firestore_service.dart';

class WaitingApprovePage extends StatelessWidget {
  const WaitingApprovePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        title: const Center(
          child: Text(
            'Waiting Approve',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Waiting for approval',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: MainButton(
                label: 'Logout',
                onPressed: () async {
                  await signOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
