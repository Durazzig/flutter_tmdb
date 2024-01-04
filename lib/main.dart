import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/local/my_preferences.dart';
import 'package:tmdb/screens/auth/auth_notifier.dart';
import 'package:tmdb/screens/auth/welcome_screen.dart';
import 'package:tmdb/screens/movies/movies_notifier.dart';
import 'package:tmdb/screens/tv/tv_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyAppPreferences();
  await Future.delayed(const Duration(milliseconds: 1));
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF242A32),
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MoviesNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => TvNotifier(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF242A32),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 24,
            ),
            bodyMedium: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 20,
            ),
          ),
        ),
        home: ChangeNotifierProvider(
          create: (context) => AuthNotifier(),
          child: const WelcomeScreen(),
        ),
      ),
    );
  }
}
