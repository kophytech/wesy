import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wesy/app/bloc/app_bloc.dart';
import 'package:wesy/home/home.dart';
import 'package:wesy/landing/view/landing_page.dart';
import 'package:wesy/login/login.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          return const HomePage();
        } else if (state.status == AuthStatus.unauthenticated) {
          return const LoginPage();
        } else {
          return const LandingPage();
        }
      },
    );
  }
}
