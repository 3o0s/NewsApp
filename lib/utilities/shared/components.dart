import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:newsapp/utilities/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';

void navigateTo(BuildContext context, Widget widget) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
}

Widget separator() => Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 1,
        color: Colors.black12,
      ),
    );

Widget buildArticleItem(article, context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: GestureDetector(
      onTap: () async {
        Uri url = Uri.parse(article['url']);
        if (await canLaunchUrl(url)) {
          await launchUrl(
            url,
          );
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //newsapp: url
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: CachedNetworkImage(
              imageUrl: article['urlToImage'] ?? brokdenImage,
              placeholder: (context, url) => const CircularProgressIndicator(
                color: Colors.deepOrange,
              ),
              errorWidget: (context, url, error) => Image.network(brokdenImage),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      //newsapp:
                      article['title'],
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    //newsapp:
                    article['publishedAt'],
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget newsListView(List list, context, [bool isSearch = false]) =>
    ConditionalBuilder(
      condition: list.isNotEmpty,
      fallback: (BuildContext context) => Center(
        child: isSearch
            ? null
            : const CircularProgressIndicator(
                color: Colors.deepOrange,
              ),
      ),
      builder: (BuildContext context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: ((BuildContext context, index) {
          return buildArticleItem(list[index], context);
        }),
        separatorBuilder: (BuildContext context, index) => separator(),
        itemCount: list.length,
      ),
    );

Widget defaultFormFeild({
  required TextEditingController controller,
  required context,
  required TextInputType type,
  required String? Function(String? value) validate,
  Function(String value)? onSubmit,
  Function(String value)? onChange,
  Function()? suffexPressed,
  Function()? onTap,
  required String label,
  required IconData prefix,
  IconData? suffex,
  bool isPassword = false,
  bool isClickable = true,
}) =>
    TextFormField(
      cursorColor: Colors.deepOrange,
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(fontWeight: FontWeight.normal),
      enabled: isClickable,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      onChanged: onChange,
      validator: validate,
      decoration: InputDecoration(
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.deepOrange,
          ),
        ),
        prefixIcon: Icon(
          prefix,
          color: Colors.deepOrange,
        ),
        suffixIcon: suffex != null
            ? IconButton(
                onPressed: suffexPressed,
                icon: Icon(
                  suffex,
                  color: Colors.deepOrange,
                ))
            : null,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
