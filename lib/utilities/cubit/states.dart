abstract class NewsAppstates {}

class NewsInitialState extends NewsAppstates {}

class BottomNavState extends NewsAppstates {}

class NewsBusinessLoadingState extends NewsAppstates {}

class NewsGetBusinessSuccessState extends NewsAppstates {}

class NewsGetBusinessErrorState extends NewsAppstates {
  final String error;
  NewsGetBusinessErrorState(this.error);
}

class NewsSportsLoadingState extends NewsAppstates {}

class NewsGetSportsSuccessState extends NewsAppstates {}

class NewsGetSportsErrorState extends NewsAppstates {
  final String error;
  NewsGetSportsErrorState(this.error);
}

class NewsScienceLoadingState extends NewsAppstates {}

class NewsGetScienceSuccessState extends NewsAppstates {}

class NewsGetScienceErrorState extends NewsAppstates {
  final String error;
  NewsGetScienceErrorState(this.error);
}

class NewsGetSearchErrorState extends NewsAppstates {
  final String error;
  NewsGetSearchErrorState(this.error);
}

class NewsSearchLoadingState extends NewsAppstates {}

class NewsGetSearchSuccessState extends NewsAppstates {}

class NewsCountryChange extends NewsAppstates {}

class NewsAppThemeButtomChangeState extends NewsAppstates {}
