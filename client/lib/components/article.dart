import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Article extends StatelessWidget {
  final article;
  Article({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Ink.image(
            image: NetworkImage(
              article['imageUrl'],
            ),
            height: 240,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16).copyWith(bottom: 0),
            child: Text(
              article['title'].trim(),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          article['author'] != "N/A"
              ? Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.all(16).copyWith(bottom: 0, top: 4),
                    child: Text(
                      "By: " + article['author'].toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(0).copyWith(bottom: 0),
                ),
          ButtonBar(alignment: MainAxisAlignment.end, children: [
            IconButton(
              iconSize: 36,
              icon: const Icon(Icons.open_in_new),
              onPressed: () async {
                await launch(article['url']);
              },
            ),
            IconButton(
              iconSize: 36,
              icon: const Icon(Icons.star_border_outlined),
              onPressed: () {},
            )
          ])
        ],
      ),
    );
  }
}
