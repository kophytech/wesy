import 'dart:async';

import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:wesy/app/app_router.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController? _animationController;
  late Animation<double>? _animation;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeIn,
    );

    _timer = Timer(
      const Duration(milliseconds: 3000),
      () => context.go(WesyPages.splash),
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: CsColors.white,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _animation!,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
