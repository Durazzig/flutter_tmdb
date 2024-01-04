import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/local/my_preferences.dart';
import 'package:tmdb/screens/auth/auth_notifier.dart';
import 'package:tmdb/screens/auth/sign_in_web_screen.dart';
import 'package:tmdb/screens/home/home_screen.dart';
import 'package:tmdb/screens/home/home_screen_notifier.dart';
import 'package:tmdb/utils/router.dart';
import 'package:tmdb/widgets/alerts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    super.key,
    required this.sessionExpired,
  });

  final bool sessionExpired;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.sessionExpired) {
      Future.microtask(
        () {
          final router = AppRouter.of(context);
          Alerts.showModal(context, "Session Expired",
              "Unfortunately, your session has expired, please sign in again, or continue as a guest",
              primaryButtonAction: () {
                MyAppPreferences.clearPreferences();
                Navigator.of(context).pop();
              },
              primaryButtonText: "Close",
              secondaryButtonAction: () {
                MyAppPreferences.clearPreferences();
                router.goToScreen(
                  ChangeNotifierProvider(
                    create: (context) => HomeScreenNotifier(
                      hasSessionId: false,
                    ),
                    child: const HomeScreen(),
                  ),
                );
              },
              secondaryButtonText: "Continue as a guest");
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = context.read<AuthNotifier>();
    final size = MediaQuery.of(context).size;
    final router = AppRouter.of(context);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Image.asset(
              "assets/movie-background-collage.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Deseas iniciar sesion o seguir como invitado?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await authNotifier.getRequestToken();
                          if (context.mounted) {
                            router.goToScreen(
                              ChangeNotifierProvider.value(
                                value: authNotifier,
                                child: const SignInWebScreen(),
                              ),
                            );
                          }
                        },
                        child: const Text("Sign in"),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    router.goToScreen(
                      ChangeNotifierProvider(
                        create: (context) => HomeScreenNotifier(
                          hasSessionId: false,
                        ),
                        child: const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Seguir como invitado",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
