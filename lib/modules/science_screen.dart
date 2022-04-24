import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/utilities/cubit/cubit.dart';
import 'package:newsapp/utilities/cubit/states.dart';
import 'package:newsapp/utilities/shared/components.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsAppstates>(
      listener: (context, state) {},
      builder: (context, state) {
        List list = NewsCubit.get(context).scienceArticles;
        return newsListView(list, context);
      },
    );
  }
}
