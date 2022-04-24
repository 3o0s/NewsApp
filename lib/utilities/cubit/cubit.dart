import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/modules/business_screen.dart';
import 'package:newsapp/modules/science_screen.dart';
import 'package:newsapp/modules/sports_screen.dart';
import 'package:newsapp/utilities/cubit/states.dart';
import 'package:newsapp/utilities/local/cach_helper.dart';
import 'package:newsapp/utilities/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsAppstates> {
  NewsCubit() : super(NewsInitialState()) {
    selectedCountry = CachHelper.getCountry(key: 'country');
    isDark = CachHelper.getThemeMode(key: 'isDark');
  }
  static NewsCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  //theme

  bool isDark = false;
  void changeBool(bool? val) {
    isDark = val ?? false;
    CachHelper.saveThemeMode(key: 'isDark', value: isDark)
        .then((value) => emit(NewsAppThemeButtomChangeState()));
  }

  // dropdown
  String selectedCountry = 'eg';
  List<DropdownMenuItem<String>> dropdownMenuItem = const [
    DropdownMenuItem(
      child: Text(
        'Egpyt',
      ),
      value: 'eg',
    ),
    DropdownMenuItem(
      child: Text('United States'),
      value: 'us',
    ),
    DropdownMenuItem(
      child: Text(
        'Japan',
      ),
      value: 'jp',
    ),
    DropdownMenuItem(
      child: Text('Saudia Arabia'),
      value: 'sa',
    ),
    DropdownMenuItem(
      child: Text('Turkey'),
      value: 'tr',
    ),
  ];
  void changeCountry(String? val) {
    businessArticles.clear();
    sportsArticles.clear();
    scienceArticles.clear();
    selectedCountry = val ?? 'eg';
    CachHelper.saveCountry(key: 'country', value: selectedCountry)
        .then((value) {
      getBusiness();
      emit(NewsCountryChange());
    });
  }

  //bottom navigation bar
  int buttomNavIndex = 0;
  void changeIndex(int index) {
    buttomNavIndex = index;
    if (index == 1) {
      getSports();
    } else if (index == 2) {
      getScience();
    }

    emit(BottomNavState());
  }

  List<String> title = const [
    'Business',
    'Sports',
    'Science',
  ];

  List<Widget> bottomNavScreens = const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<BottomNavigationBarItem> buttomNavItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];

  // api
  List<dynamic> businessArticles = [];
  List<dynamic> sportsArticles = [];
  List<dynamic> scienceArticles = [];

  void getBusiness() {
    emit(NewsBusinessLoadingState());
    if (businessArticles.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': selectedCountry,
          'category': 'business',
          'apiKey': 'b525a3f569a94a58be588143e2a31c0b'
        },
      ).then((fetchedData) {
        businessArticles = fetchedData.data['articles'];
        emit(NewsGetBusinessSuccessState());
      }).catchError((err) {
        emit(NewsGetBusinessErrorState(err.toString()));
      });
      emit(NewsGetBusinessSuccessState());
    }
  }

  void getSports() {
    if (sportsArticles.isEmpty) {
      emit(NewsSportsLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': selectedCountry,
          'category': 'sports',
          'apiKey': 'b525a3f569a94a58be588143e2a31c0b'
        },
      ).then((fetchedData) {
        sportsArticles = fetchedData.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((err) {
        emit(NewsGetSportsErrorState(err.toString()));
      });
    }
  }

  void getScience() {
    emit(NewsScienceLoadingState());
    if (scienceArticles.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': selectedCountry,
          'category': 'science',
          'apiKey': 'b525a3f569a94a58be588143e2a31c0b'
        },
      ).then((fetchedData) {
        scienceArticles = fetchedData.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((err) {
        emit(NewsGetScienceErrorState(err.toString()));
      });
    }
  }
  //search https://newsapi.org/v2/everything?q=tesla&apiKey=b525a3f569a94a58be588143e2a31c0b

  TextEditingController searchContoller = TextEditingController(text: '');
  List<dynamic> search = [];

  void getSearch() {
    emit(NewsSearchLoadingState());
    search.clear();
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': searchContoller.text,
        'apiKey': 'b525a3f569a94a58be588143e2a31c0b'
      },
    ).then((fetchedData) {
      search = fetchedData.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((err) {
      emit(NewsGetSearchErrorState(err.toString()));
    });
    print(search.length);
  }
}
