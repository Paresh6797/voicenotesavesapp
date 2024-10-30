import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'bloc_and_repository_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlays
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.grey.shade300, // Status bar color
    statusBarIconBrightness: Brightness.dark, // Dark icons on light background
  ));

  // Lock orientation to portrait mode
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Preserve the splash screens while initialization happens
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  // Remove the splash screens and run the app
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();

  // Initialize and run the app
  runApp(const BlocAndRepositoryProvider());
}

