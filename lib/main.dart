import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/ui/screens/login_screen.dart';
import 'package:rare_crew/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>(
  (ref) async {
    return SharedPreferences.getInstance();
  },
);

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
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
