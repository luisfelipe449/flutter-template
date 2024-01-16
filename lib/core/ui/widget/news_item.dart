import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_starter/core/ui/widget/labeled_text_button.dart';

class NewsItemWidget extends StatelessWidget {
  const NewsItemWidget({required this.newsItem, super.key});
  final NewsItem newsItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Icon(
                newsItem.imageUrl ?? Icons.error,
                color: const Color.fromARGB(255, 39, 99, 63),
                size: 50,
              ),
              const SizedBox(height: 5),
              Text(
                newsItem.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 39, 99, 63),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
      onTap: () {},
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
  final IconData imageUrl;
}
