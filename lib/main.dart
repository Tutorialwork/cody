import 'package:cody/services/get_it_service.dart';
import 'package:cody/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  GetItService.registerSingletons();

  runApp(MaterialApp(
    home: SplashScreen(),
  ));
}
