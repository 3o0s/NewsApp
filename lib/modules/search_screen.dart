import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/utilities/cubit/cubit.dart';
import 'package:newsapp/utilities/cubit/states.dart';
import 'package:newsapp/utilities/shared/components.dart';

class SeacrchScreen extends StatelessWidget {
  const SeacrchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsAppstates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit newsCubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('', style: Theme.of(context).textTheme.bodyText1),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(18, 5, 10, 0),
              child: Column(
                children: [
                  defaultFormFeild(
                    context: context,
                    controller: newsCubit.searchContoller,
                    type: TextInputType.text,
                    validate: (String? val) {
                      if (val!.isEmpty) {
                        return 'Search cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    label: 'Search',
                    prefix: Icons.search,
                    onChange: (String val) {
                      newsCubit.getSearch();
                    },
                  ),
                  Expanded(
                      child: newsListView(newsCubit.search, context, true)),
                ],
              ),
            ),
          );
        });
  }
}
