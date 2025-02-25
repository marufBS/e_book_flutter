// import 'package:flutter/cupertino.dart';
import 'package:e_book/app_colors.dart' as app_colors;
import 'package:e_book/my_tabs.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
   // List? popularBooksDisplay;
   // List? newBooks;
   // List? popularBooks;
   // List? trendyBooks;
  List<Map<String, dynamic>> popularBooksDisplay = [];
  List<Map<String, dynamic>> newBooks = [];
  List<Map<String, dynamic>> popularBooks = [];
  List<Map<String, dynamic>> trendyBooks = [];
  late ScrollController _scrollController;
  late TabController _tabController;

  Future<void> readData() async{
    final jsonFiles = [
      'json/popularBooksDisplay.json',
      'json/newBooks.json',
      'json/popularBooks.json',
      'json/trendyBooks.json',
    ];

    final data = await Future.wait(
        jsonFiles.map((file)=>DefaultAssetBundle.of(context).loadString(file))
    );

    setState(() {
      popularBooksDisplay = json.decode(data[0]);
      newBooks = json.decode(data[1]);
      popularBooks = json.decode(data[2]);
      trendyBooks = json.decode(data[3]);
    });
  }

  // readData() async {
  //   await DefaultAssetBundle.of(
  //     context,
  //   ).loadString("json/popularBooksDisplay.json").then((s) {
  //     setState(() {
  //       popularBooksDisplay = json.decode(s);
  //     });
  //   });
  //
  //   await DefaultAssetBundle.of(context).loadString("json/newBooks.json").then((
  //     s,
  //   ) {
  //     setState(() {
  //       newBooks = json.decode(s);
  //     });
  //   });
  //
  //   await DefaultAssetBundle.of(context).loadString("json/popularBooks.json").then((
  //     s,
  //   ) {
  //     setState(() {
  //       popularBooks = json.decode(s);
  //     });
  //   });
  //
  //   await DefaultAssetBundle.of(context).loadString("json/trendyBooks.json").then((
  //     s,
  //   ) {
  //     setState(() {
  //       trendyBooks = json.decode(s);
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: app_colors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(height: 20),
              // Top section
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
              //Popular Books title
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
              //Carousel
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
                        //Carousel builder
                        child: PageView.builder(
                          controller: PageController(viewportFraction: 0.8),
                          // itemCount:popularBooksDisplay == null ? 0 : popularBooksDisplay?.length,
                          itemCount: popularBooksDisplay.length,
                          itemBuilder: (_, i) {
                            return Container(
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                  // image: AssetImage(popularBooksDisplay?[i]["img"]),
                                  image: AssetImage(popularBooksDisplay[i]["img"]),
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
              SizedBox(height: 20,),
              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool isScroll) {
                    // SliverAppBar
                    return [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: app_colors.sliverBackground,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(20),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10, left: 10),
                            // color: Colors.black,
                            child: TabBar(
                              indicatorPadding: const EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.only(right: 10),
                              controller: _tabController,
                              isScrollable: false,
                              // indicator: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(10),
                              //   boxShadow: [
                              //     BoxShadow(
                              //       color: Colors.grey.withOpacity(0.2),
                              //       blurRadius: 7,
                              //       offset: Offset(0, 0),
                              //     ),
                              //   ],
                              // ),
                              tabs: [
                                AppTabs(
                                  color: app_colors.menu1Color,
                                  text: "New",
                                ),
                                AppTabs(
                                  color: app_colors.menu2Color,
                                  text: "Popular",
                                ),
                                AppTabs(
                                  color: app_colors.menu3Color,
                                  text: "Trendy",
                                ),
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
                      ListView.builder(
                        // itemCount: newBooks == null ? 0 : newBooks?.length,
                        itemCount: newBooks.length,
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
                                    color: Colors.grey.withAlpha((0.2*255).toInt())
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
                                          // image: AssetImage(newBooks?[i]["img"]),
                                          image: AssetImage(newBooks[i]["img"]),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              newBooks[i]["rating"],
                                              // newBooks?[i]["rating"],
                                              style: TextStyle(
                                                color: app_colors.menu2Color,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          newBooks[i]["title"],
                                          // newBooks?[i]["title"],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Avenir",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          newBooks[i]["text"],
                                          // newBooks?[i]["text"],
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
                                            borderRadius: BorderRadius.circular(
                                              3,
                                            ),
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
                      ),
                      ListView.builder(
                        // itemCount: popularBooks == null ? 0 : popularBooks?.length,
                        itemCount: popularBooks.length,
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
                                    color: Colors.grey.withAlpha((0.2*255).toInt()),
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
                                          image: AssetImage(popularBooks[i]["img"]),
                                          // image: AssetImage(popularBooks?[i]["img"]),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              popularBooks[i]["rating"],
                                              // popularBooks?[i]["rating"],
                                              style: TextStyle(
                                                color: app_colors.menu2Color,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          popularBooks[i]["title"],
                                          // popularBooks?[i]["title"],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Avenir",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          popularBooks[i]["text"],
                                          // popularBooks?[i]["text"],
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
                                            borderRadius: BorderRadius.circular(
                                              3,
                                            ),
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
                      ),
                      ListView.builder(
                        // itemCount: trendyBooks == null ? 0 : trendyBooks?.length,
                        itemCount: trendyBooks.length,
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
                                    color: Colors.grey.withAlpha((0.2*255).toInt()),
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
                                          image: AssetImage(trendyBooks[i]["img"]),
                                          // image: AssetImage(trendyBooks?[i]["img"]),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              trendyBooks[i]["rating"],
                                              // trendyBooks?[i]["rating"],
                                              style: TextStyle(
                                                color: app_colors.menu2Color,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          trendyBooks[i]["title"],
                                          // trendyBooks?[i]["title"],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Avenir",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          trendyBooks[i]["text"],
                                          // trendyBooks?[i]["text"],
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
                                            borderRadius: BorderRadius.circular(
                                              3,
                                            ),
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
