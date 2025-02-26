import 'package:flutter/material.dart';
import 'package:e_book/app_colors.dart' as app_colors;

class AppTabView extends StatelessWidget {
  final List<Map<String, dynamic>> books;
  const AppTabView({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (_, i) {
        return Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 10,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: app_colors.tabVarViewColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  offset: Offset(0, 0),
                  color: Colors.grey.withAlpha((0.2 * 255).toInt()),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(books[i]["img"]),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Stars row
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 24,
                            color: app_colors.starColor,
                          ),
                          SizedBox(width: 5),
                          Text(
                            books[i]["rating"],
                            style: TextStyle(color: app_colors.menu2Color),
                          ),
                        ],
                      ),
                      Text(
                        books[i]["title"],
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        books[i]["text"],
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Avenir",
                          color: app_colors.subTitleText,
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: app_colors.loveColor,
                        ),
                        child: Text(
                          "Love",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Avenir",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
