import 'package:e_book/app_colors.dart' as app_colors;
import 'package:e_book/my_tab_view.dart';
import 'package:e_book/my_tabs.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:logger/logger.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  // Lists to hold book data
  List<Map<String, dynamic>> popularBooksDisplay = [];
  List<Map<String, dynamic>> newBooks = [];
  List<Map<String, dynamic>> popularBooks = [];
  List<Map<String, dynamic>> trendyBooks = [];

  late ScrollController _scrollController;
  late TabController _tabController;

  final Logger logger = Logger();

  // Function to read data from JSON files
  Future<void> readData() async {
    try {
      final jsonFiles = [
        'json/popularBooksDisplay.json',
        'json/newBooks.json',
        'json/popularBooks.json',
        'json/trendyBooks.json',
      ];

      final data = await Future.wait(
        jsonFiles.map(
          (file) => DefaultAssetBundle.of(context).loadString(file),
        ),
      );

      setState(() {
        popularBooksDisplay = List<Map<String, dynamic>>.from(
          json.decode(data[0]),
        );
        newBooks = List<Map<String, dynamic>>.from(json.decode(data[1]));
        popularBooks = List<Map<String, dynamic>>.from(json.decode(data[2]));
        trendyBooks = List<Map<String, dynamic>>.from(json.decode(data[3]));
      });
    } catch (e) {
      logger.e('Error loading data:', e);
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    readData(); // Load data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: app_colors.background,
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (BuildContext context, bool isScroll) {
              return [
                // Top section + Popular Books title + Carousel
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      // Top section with menu, search, and notifications icons
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ImageIcon(
                              AssetImage("img/menu.png"),
                              size: 24,
                              color: Colors.black,
                            ),
                            Row(
                              children: [
                                Icon(Icons.search),
                                SizedBox(width: 10),
                                Icon(Icons.notifications),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      // Popular Books title
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Text(
                              "Popular Books",
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Carousel for popular books display
                      SizedBox(
                        height: 180,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: -20,
                              right: 0,
                              child: SizedBox(
                                height: 180,
                                child: PageView.builder(
                                  controller: PageController(
                                    viewportFraction: 0.8,
                                  ),
                                  itemCount: popularBooksDisplay.length,
                                  itemBuilder: (_, i) {
                                    return Container(
                                      height: 180,
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          15.0,
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            popularBooksDisplay[i]["img"],
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                // Slider Buttons
                SliverAppBar(
                  pinned: true,
                  backgroundColor: app_colors.sliverBackground,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(20),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10, left: 10),
                      child: TabBar(
                        indicatorPadding: const EdgeInsets.all(0),
                        indicatorSize: TabBarIndicatorSize.label,
                        labelPadding: const EdgeInsets.only(right: 10),
                        controller: _tabController,
                        isScrollable: false,
                        tabs: [
                          AppTabs(color: app_colors.menu1Color, text: "New"),
                          AppTabs(
                            color: app_colors.menu2Color,
                            text: "Popular",
                          ),
                          AppTabs(color: app_colors.menu3Color, text: "Trendy"),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                // List view for new books
                AppTabView(books: newBooks),
                AppTabView(books: popularBooks),
                AppTabView(books: trendyBooks),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
