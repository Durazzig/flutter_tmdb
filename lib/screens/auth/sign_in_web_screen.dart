import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/screens/auth/auth_notifier.dart';
import 'package:tmdb/screens/home/home_screen.dart';
import 'package:tmdb/screens/home/home_screen_notifier.dart';
import 'package:tmdb/utils/router.dart';

class SignInWebScreen extends StatelessWidget {
  const SignInWebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authNotifier = context.read<AuthNotifier>();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: InAppWebView(
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
            ),
            android: AndroidInAppWebViewOptions(
              useShouldInterceptRequest: true,
            ),
          ),
          initialUrlRequest: URLRequest(
            url: Uri.parse(
              "https://www.themoviedb.org/authenticate/${authNotifier.requestToken}?redirect_to=https://www.flutter-tmdb.com/approved",
            ),
          ),
          onLoadStart: (controller, url) async {
            //Android has a weird behavior for redirects, because the webview doesnt "catch" the url thats its being tried to load only after it started loading
            //So we end up with an error screen for a second until the user is moved back to the home screen.
            if (context.mounted) {
              logUser(context, url.toString());
            }
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            final url = await controller.getUrl();
            if (context.mounted) {
              logUser(context, url.toString());
            }
            return NavigationActionPolicy.ALLOW;
          },
          onCreateWindow: (controller, createWindowAction) async {
            return true;
          },
        ),
      ),
    );
  }

  void logUser(BuildContext context, String url) async {
    final authNotifier = context.read<AuthNotifier>();
    final router = AppRouter.of(context);
    if (url.contains("https://www.flutter-tmdb.com/approved?request_token")) {
      final sessionId = await authNotifier.getSessionID();
      if (context.mounted) {
        if (sessionId != null) {
          await authNotifier.getProfileInformation();
          router.goToScreen(
            ChangeNotifierProvider(
              create: (context) => HomeScreenNotifier(
                hasSessionId: true,
              ),
              child: const HomeScreen(),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Sign in error'),
                content: const Text(
                  'There was a problem retrieving your account information, please try again later or continue as a guest.',
                ),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Continue as a guest'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => HomeScreenNotifier(
                              hasSessionId: false,
                            ),
                            child: const HomeScreen(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }
}
