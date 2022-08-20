import 'package:flutter/material.dart';
import 'package:rare_crew/ui/screens/login_screen.dart';
import 'package:rare_crew/utils/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rare Crew Task',
      debugShowCheckedModeBanner: false,
      theme: rareCrewTheme,
      home: const LoginScreen(),
    );
  }
}
