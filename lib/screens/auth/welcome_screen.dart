import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/screens/auth/auth_notifier.dart';
import 'package:tmdb/screens/auth/sign_in_screen.dart';
import 'package:tmdb/screens/home/home_screen.dart';
import 'package:tmdb/screens/home/home_screen_notifier.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late AuthNotifier authNotifier;

  @override
  void initState() {
    super.initState();
    authNotifier = context.read<AuthNotifier>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: authNotifier.getSessionIdFromPreferences(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.data! != "") {
                return ChangeNotifierProvider(
                  create: (context) => HomeScreenNotifier(
                    hasSessionId: true,
                  ),
                  child: const HomeScreen(),
                );
              } else {
                return const SignInScreen(
                  sessionExpired: true,
                );
              }
            } else {
              return const SignInScreen(
                sessionExpired: false,
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
