import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/local/my_preferences.dart';
import 'package:tmdb/screens/auth/auth_notifier.dart';
import 'package:tmdb/screens/auth/sign_in_screen.dart';
import 'package:tmdb/screens/home/home_screen_notifier.dart';
import 'package:tmdb/screens/movies/movies_screen.dart';
import 'package:tmdb/screens/search/search_notifier.dart';
import 'package:tmdb/screens/search/search_screen.dart';
import 'package:tmdb/screens/watch_lists/watch_lists_notifier.dart';
import 'package:tmdb/screens/watch_lists/watch_lists_screen.dart';
import 'package:tmdb/widgets/alerts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenNotifier homeNotifier;

  @override
  void initState() {
    homeNotifier = context.read<HomeScreenNotifier>();
    homeNotifier.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: appBar(),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: homeNotifier.pageController,
          children: [
            const MoviesScreen(
              displayMovies: true,
            ),
            ChangeNotifierProvider(
              create: (context) => SearchNotifier(),
              child: const SearchScreen(),
            ),
            const MoviesScreen(
              displayMovies: false,
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  WatchListsNotifier(hasSessionId: homeNotifier.hasSessionId),
              child: const WatchListsScreen(),
            ),
          ],
        ),
        bottomNavigationBar: bottomBar(),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "TMDB",
          style: TextStyle(fontSize: 26),
        ),
      ),
      actions: homeNotifier.hasSessionId
          ? [
              Builder(builder: (ctx) {
                return IconButton(
                  onPressed: () {
                    Alerts.showModal(
                      ctx,
                      "Sign out",
                      "Are you sure you want to sign",
                      primaryButtonText: "Sign out",
                      primaryButtonAction: () async {
                        await MyAppPreferences.clearPreferences();
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                create: (context) => AuthNotifier(),
                                child: const SignInScreen(
                                  sessionExpired: false,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                  icon: const Icon(Icons.logout),
                );
              }),
            ]
          : null,
      backgroundColor: const Color(0xFF242A32),
      elevation: 0,
    );
  }

  Widget bottomBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
      child: Consumer<HomeScreenNotifier>(builder: (context, notifier, child) {
        return BottomNavigationBar(
          backgroundColor: const Color(0xFF242A32),
          unselectedItemColor: Colors.grey,
          currentIndex: notifier.index,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            homeNotifier.changePage(value);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              label: "Movies",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              label: "Tv",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Watch List",
            ),
          ],
        );
      }),
    );
  }
}
