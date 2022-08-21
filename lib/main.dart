import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rare_crew/core/repositories/auth_repository.dart';
import 'package:rare_crew/ui/screens/dashboard/dashboard_container.dart';
import 'package:rare_crew/ui/screens/signin_screen.dart';
import 'package:rare_crew/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final sharedPreferencesProvider = FutureProvider<SharedPreferences>(
//   (ref) async {
//     return SharedPreferences.getInstance();
//   },
// );

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Rare Crew Task',
      debugShowCheckedModeBanner: false,
      theme: rareCrewTheme,
      home: ref.read(authRepositoryProvider).getToken() != null
          ? const DashboardContainer()
          : const SignInScreen(),
    );
  }
}
