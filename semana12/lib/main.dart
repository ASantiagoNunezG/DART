import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'screens/registration_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = UniversalPlatform.isWeb || UniversalPlatform.isIOS ;

    return MaterialApp(
      title: 'Registro',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: isWeb 
          ? const RegistrationScreen(useCupertino: true) 
          : const RegistrationScreen(useCupertino: false),
    );
  }
}
