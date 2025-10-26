import 'package:flutter/material.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/dailyRecord.dart';
import 'package:habitican/database/dailyTasks.dart';
import 'package:habitican/database/habits.dart';
import 'package:habitican/database/tasks.dart';
import 'package:habitican/pages/add_screen.dart';
import 'package:habitican/pages/dashboard.dart';
// import 'package:habitican/pages/testing_code.dart';
import 'package:habitican/pages/tracker_screen.dart';
import 'package:habitican/utils/daily_records_manager.dart';
import 'package:habitican/utils/global_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HabitsAdapter());
  Hive.registerAdapter(TasksAdapter());
  Hive.registerAdapter(DailyTasksAdapter());
  Hive.registerAdapter(DailyRecordAdapter());
  boxHabits = await Hive.openBox<Habits>('habitsBox');
  boxTasks = await Hive.openBox<Tasks>('tasksBox');
  boxDailyTasks = await Hive.openBox<DailyTasks>('dailyTasksBox');
  boxDailyRecords = await Hive.openBox<DailyRecord>('dailyRecordBox');
  // Initialize daily records after Hive boxes are opened. The actual call
  // is moved into AppLayout.initState so that a provider is available to be
  // notified after records are added.
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

  @override
  void initState() {
    super.initState();
    // Run dailyRecordsManager after the first frame so the provider is available
    // and can be notified/refreshed with any new records that were added.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await dailyRecordsManager();
      final provider = Provider.of<GlobalStateProvider>(context, listen: false);
      // Refresh the provider's cached record for the currently selected date
      // and notify listeners so UI reflects newly-created daily records.
      provider.updateRecord(provider.selectedDate);
    });
  }
}
