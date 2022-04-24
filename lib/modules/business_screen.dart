import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/utilities/cubit/cubit.dart';
import 'package:newsapp/utilities/cubit/states.dart';
import 'package:newsapp/utilities/shared/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsAppstates>(
      listener: (context, state) {},
      builder: (context, state) {
        List list = NewsCubit.get(context).businessArticles;
        return newsListView(list, context);
      },
    );
  }
}
