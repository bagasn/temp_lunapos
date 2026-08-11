import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pos/app.dart';
import 'package:pos/core/di/injection_container.dart';
import 'package:pos/core/firebase/firebase_options_dev.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'envs/dev.env');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies(Env.dev);
  runApp(const LunaposApp());
}
