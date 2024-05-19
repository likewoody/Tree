import 'package:flutter/material.dart';
import 'package:td_app/view/common/appbar.dart';

class Detail extends StatelessWidget {
  const Detail({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: CommonAppbar(),
      ),
      body: Center(child: Text("detail page"),),
    );
  }
}