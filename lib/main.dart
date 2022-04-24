import 'package:flutter/material.dart';
import 'package:newsapp/layout/news_app/news_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/utilities/cubit/cubit.dart';
import 'package:newsapp/utilities/cubit/states.dart';
import 'package:newsapp/utilities/local/cach_helper.dart';
import 'package:newsapp/utilities/network/remote/dio_helper.dart';
import 'package:newsapp/utilities/shared/bloc_observer.dart';
import 'package:newsapp/utilities/shared/constants.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  CachHelper.init();
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit, NewsAppstates>(
        listener: ((context, state) {}),
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode:
              NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home: const NewsLayout(),
        ),
      ),
    );
  }
}
