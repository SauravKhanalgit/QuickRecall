import 'package:QUICKRECALL/core/theme/app_theme.dart';
import 'package:QUICKRECALL/models/flashcard.dart';
import 'package:QUICKRECALL/screens/consent_screen.dart';

import 'package:QUICKRECALL/screens/splash_screen.dart';

// ignore: depend_on_referenced_packages
// import 'package:QUICKRECALL/models/flashcard.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startapp_sdk/startapp.dart';
import 'screens/flashcard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(FlashcardAdapter());
  await Hive.openBox<Flashcard>('QUICKRECALL');
  await Hive.openBox('userData');
  // runApp(const MyApp());
  final prefs = await SharedPreferences.getInstance();
  bool hasConsented = prefs.getBool('userConsent') ?? false;

  runApp(MyApp(hasConsented));
}

class MyApp extends StatefulWidget {
  const MyApp(bool hasConsented, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final startAppSdk = StartAppSdk();
  StartAppBannerAd? bannerAd;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QUICKRECALL',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: _buildHome(),
    );
  }
}

Widget _buildHome() {
  return FutureBuilder<bool>(
    future: _checkConsent(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return Center(child: Text("Error: \${snapshot.error}"));
      }
      if (snapshot.hasData && !snapshot.data!) {
        return ConsentScreen(); // Show ConsentScreen if user hasn't given consent
      }
      return SplashScreen();
    },
  );
}

Future<bool> _checkConsent() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('userConsent') ?? false;
}
