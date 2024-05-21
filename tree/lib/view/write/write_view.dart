import 'package:flutter/material.dart';

class WriteView extends StatelessWidget {
  WriteView({super.key});

  final TextEditingController travelPlaceController = TextEditingController();
  final TextEditingController day1Controller = TextEditingController();
  final TextEditingController day2Controller = TextEditingController();
  final TextEditingController travelMateController = TextEditingController();
  final TextEditingController weatherController = TextEditingController();
  final TextEditingController writeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: travelPlaceController,
            ),
            TextField(
              controller: day1Controller,
            ),
            TextField(
              controller: day2Controller,
            ),
            TextField(
              controller: travelMateController,
            ),
            TextField(
              controller: weatherController,
            ),
            TextField(
              controller: writeController,
            )
          ],
        ),
      ),
    );
  }
}
