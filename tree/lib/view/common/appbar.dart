import 'package:flutter/material.dart';

class CommonAppbar extends StatelessWidget {
  const CommonAppbar({super.key,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AppBar(
        toolbarHeight: 80,
        title: Column(
          children: [
            Image.asset(
              "images/tree.png",
              width: 40,
              height: 40,
              fit: BoxFit.fill,
            )
          ],
        ),
      ),
    );
  }
}