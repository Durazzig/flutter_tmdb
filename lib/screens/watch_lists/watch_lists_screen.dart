import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/screens/auth/auth_notifier.dart';
import 'package:tmdb/screens/auth/welcome_screen.dart';
import 'package:tmdb/screens/watch_lists/watch_list_details_screen.dart';
import 'package:tmdb/screens/watch_lists/watch_lists_notifier.dart';
import 'package:tmdb/utils/router.dart';

class WatchListsScreen extends StatefulWidget {
  const WatchListsScreen({super.key});

  @override
  State<WatchListsScreen> createState() => _WatchListsScreenState();
}

class _WatchListsScreenState extends State<WatchListsScreen> {
  late WatchListsNotifier watchListsNotifier;

  @override
  void initState() {
    super.initState();
    watchListsNotifier = context.read<WatchListsNotifier>();
    if (watchListsNotifier.hasSessionId) {
      watchListsNotifier.init();
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.of(context);
    return Scaffold(
      body: watchListsNotifier.hasSessionId
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Watch Lists"),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: watchListsNotifier.watchListsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            final watchLists = snapshot.data!;
                            if (watchLists.isEmpty) {
                              return const Center(
                                child: Text("You dont have any watch lists"),
                              );
                            } else {
                              return RefreshIndicator(
                                onRefresh: () async {
                                  setState(() {
                                    watchListsNotifier.init();
                                  });
                                },
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    final watchList = watchLists[index];
                                    return GestureDetector(
                                      onTap: () {
                                        watchListsNotifier
                                            .setSelectedListId(watchList);
                                        router.goToScreen(
                                          ChangeNotifierProvider.value(
                                            value: watchListsNotifier,
                                            child:
                                                const WatchListDetailsScreen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        width: double.infinity,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(watchList.name),
                                            Text(
                                              watchList.description == ""
                                                  ? "No description available"
                                                  : watchList.description,
                                            ),
                                            Row(
                                              children: [
                                                const Text("Movies in list:"),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text("${watchList.itemCount}"),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    "${watchList.favoriteCount}"),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 20,
                                    );
                                  },
                                  itemCount: watchLists.length,
                                ),
                              );
                            }
                          } else {
                            return const Center(
                              child: Text(
                                "There was a problem fetching your watch lists, please try again later",
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "To access your watch lists, please sign in before.",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              router.goToScreenAndClear(
                                ChangeNotifierProvider(
                                  create: (context) => AuthNotifier(),
                                  child: const WelcomeScreen(),
                                ),
                              );
                            },
                            child: const Text("Sign in"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
