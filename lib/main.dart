import 'package:auth_repository/auth_repository.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:cs_storage/cs_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wesy/app/app.dart';
import 'package:wesy/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    App(
      authRepository: AuthRepository(
        csStorage: CsStorage(prefs: sharedPreferences),
      ),
      csRepository: CsRepository(),
    ),
  );
}
