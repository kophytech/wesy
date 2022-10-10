import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Oops you lost your way',
          style: CsTextStyle.headline3,
        ),
      ),
    );
  }
}
