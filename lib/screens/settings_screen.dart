import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_task/provider/db_provider.dart';

import '../generated/l10n.dart';
import '../machine_test/banner.dart';
import '../machine_test/categories.dart';
import '../machine_test/home_provider.dart';
import '../machine_test/products.dart';
import '../machine_test/search_home.dart';
import '../provider/favourites_provider.dart';
import '../shimmer/custom_widget.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData? dynamicLink) async{
      final Uri? deepLink = dynamicLink?.link;
      print(deepLink?.path);
    },
    onError: (OnLinkErrorException e)async
        {
          print(e.message);
        }
    );
    Future.microtask(() =>context.read<HomeProvider>().getData() );
    Future.microtask(() => context.read<FavouritesProvider>().loadFavList());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final translated = S.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<HomeProvider>(builder: (context, snapshot, child) {
          // if (snapshot.homeModel?.homeData == null) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Column(
              children: [
                SearchWidget(),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CategoriesWidget(),
                        HomeBanner(),
                        ProductsWidget()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
