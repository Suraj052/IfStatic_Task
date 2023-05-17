import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Provider/restaurant_provider.dart';
import 'View/home_page.dart';

void main() {

  //To customise the status app theme
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xFFFFE1E2),
    statusBarIconBrightness: Brightness.dark
  ));

  runApp(
      ChangeNotifierProvider(
        create: (BuildContext context) => RestaurantProvider(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home:MyApp()),
  ));
}

//List of bottom navigation bar items
List<TabItem> items = [
  TabItem(
    icon: Icons.grid_view_rounded,
    title: 'Home',
  ),
  TabItem(
    icon: Icons.video_settings_rounded,
    //title: 'YouTube',
  ),
  TabItem(
    icon: Icons.center_focus_strong,
    //title: 'Scan',
  ),
  TabItem(
    icon: Icons.bookmark,
    //title: 'Bookmark',
  ),
  TabItem(
    icon: Icons.person,
    //title: 'Profile',
  ),
];

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int visit = 0;
  final screens = [
    HomePage(),
    Center(child:Text("YouTube Page")),
    Center(child:Text("Scan")),
    Center(child:Text("Bookmark Page")),
    Center(child:Text("User Profile Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[visit],
      bottomNavigationBar: BottomBarCreative(
        items: items,
        backgroundColor: Colors.white,
        color: Colors.red.withOpacity(0.7),
        colorSelected: Color(0xffff0000),
        indexSelected: visit,
        isFloating: true,
        highlightStyle:const HighlightStyle(sizeLarge: true, background: Colors.red, elevation: 10),
        onTap: (int index) => setState(() {
          visit = index;
        }),
      ),
    );
  }
}

