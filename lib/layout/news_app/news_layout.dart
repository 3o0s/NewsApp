import 'package:flutter/material.dart';
import 'package:newsapp/modules/news_settings.dart';
import 'package:newsapp/modules/search_screen.dart';
import 'package:newsapp/utilities/cubit/cubit.dart';
import 'package:newsapp/utilities/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/utilities/shared/components.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsAppstates>(
      builder: (BuildContext context, state) {
        NewsCubit newsItems = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              newsItems.title[newsItems.buttomNavIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, const SeacrchScreen());
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.deepOrange,
                ),
              ),
              IconButton(
                onPressed: () {
                  navigateTo(context, const SettingsScreen());
                },
                icon: const Icon(
                  Icons.settings,
                ),
              ),
            ],
          ),
          body: newsItems.bottomNavScreens[newsItems.buttomNavIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              newsItems.changeIndex(index);
            },
            items: newsItems.buttomNavItems,
            currentIndex: newsItems.buttomNavIndex,
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
