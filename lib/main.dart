import 'package:flutter/material.dart';
import 'package:habitican/pages/add_screen.dart';
import 'package:habitican/pages/dashboard.dart';
// import 'package:habitican/pages/testing_code.dart';
import 'package:habitican/pages/tracker_screen.dart';
import 'package:habitican/utils/global_state_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GlobalStateProvider(),
      child: MaterialApp(
        title: 'habitician',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        home: AppLayout(),
      ),
    );
  }
}

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int currentPage = 0;

  List<Widget> pages = [
    Dashboard(),
    AddScreen(),
    TrackerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: currentPage,
          children: pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // selectedFontSize: 0,
        // unselectedFontSize: 0,
        currentIndex: currentPage,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              // color: Colors.black,
            ),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.edit_calendar_outlined,
          //    color: Colors.black,
          //   ),
          //   label: '',
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_outlined,
              // color: Colors.black,
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.track_changes,
              // color: Colors.black,
            ),
            label: 'Progress',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.account_circle,
          //    color: Colors.black,
          //   ),
          //   label: '',
          // ),
        ],
      ),
    );
  }
}
