import 'package:flutter/material.dart';

class NewsItemWidget extends StatelessWidget {
  const NewsItemWidget({required this.newsItem, super.key});
  final NewsItem newsItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            newsItem.imageUrl,
            //width: 50,
            height: 250,
            matchTextDirection: true,
          ),
          const SizedBox(height: 5),
          Text(
            newsItem.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(newsItem.description),
          const SizedBox(height: 20),
        ],
      ),
      //leading: Image.network(newsItem.imageUrl, width: 50, height: 50),
      onTap: () {
        // Add any action you want when a news item is tapped
      },
    );
  }
}

class NewsItem {
  NewsItem({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
  final String title;
  final String description;
  final String imageUrl;
}
