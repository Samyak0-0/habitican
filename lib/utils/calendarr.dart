import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/dailyRecord.dart';
import 'package:habitican/utils/day_progress_circular_bar.dart';
import 'package:habitican/utils/global_state_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:noted/core/app_colors.dart';

class MonthlyScreen extends StatefulWidget {
  const MonthlyScreen({super.key});

  @override
  State<MonthlyScreen> createState() => _MonthlyScreenState();
}

class _MonthlyScreenState extends State<MonthlyScreen> {
  late DateTime currentMonth;
  late List<DateTime> datesGrid;
  // DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    currentMonth = DateTime.now();
    datesGrid = _generateDatesGrid(currentMonth);
  }

  List<DateTime> _generateDatesGrid(DateTime month) {
    int numDays = DateTime(month.year, month.month + 1, 0).day;
    int firstWeekday = DateTime(month.year, month.month, 1).weekday % 7;
    List<DateTime> dates = [];

    // Fill previous month's dates
    DateTime previousMonth = DateTime(month.year, month.month - 1);
    int previousMonthLastDay = DateTime(
      previousMonth.year,
      previousMonth.month + 1,
      0,
    ).day;
    for (int i = firstWeekday; i > 0; i--) {
      dates.add(
        DateTime(
          previousMonth.year,
          previousMonth.month,
          previousMonthLastDay - i + 1,
        ),
      );
    }

    // Fill current month's dates
    for (int day = 1; day <= numDays; day++) {
      dates.add(DateTime(month.year, month.month, day));
    }

    // Fill next month's dates
    int remainingBoxes = 42 - dates.length; // 6 weeks * 7 days
    for (int day = 1; day <= remainingBoxes; day++) {
      dates.add(DateTime(month.year, month.month + 1, day));
    }

    return dates;
  }

  void _changeMonth(int offset) {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + offset);
      datesGrid = _generateDatesGrid(currentMonth);
    });
  }

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalStateProvider>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => _changeMonth(-1),
            ),
            Text(
              '${_monthName(currentMonth.month)} ${currentMonth.year}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () => _changeMonth(1),
            ),
          ],
        ),
        const Gap(12),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              7,
              (index) => Text(
                ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][index],
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ),
        ),
        const Gap(12),
        Flexible(
          child: ValueListenableBuilder(
            valueListenable: boxDailyRecords.listenable(),
            builder: (context, value, child) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                ),
                itemCount: datesGrid.length,
                itemBuilder: (context, index) {
                  DateTime date = datesGrid[index];
                  bool isCurrentMonth = date.month == currentMonth.month;
                  bool isSelected = _isSameDate(globalState.selectedDate, date);

                  DailyRecord? dailyRecord = boxDailyRecords.get(
                    date.toString().split(" ")[0],
                  );

                  // Compute per-day percentages from the DailyRecord for this
                  // calendar cell instead of using the provider's currently
                  // selected-date percentages. This prevents updating one
                  // day's visuals from affecting other dates' displays.
                  double habitPercentForDate = 0;
                  double taskPercentForDate = 0;
                  if (dailyRecord != null) {
                    final int completedHabits = dailyRecord.isHabitCompleted
                        .where((e) => e == true)
                        .length;
                    final int habitLen = dailyRecord.isHabitCompleted.length;
                    habitPercentForDate = habitLen > 0
                        ? completedHabits / habitLen
                        : 0;

                    final int completedTasks =
                        dailyRecord.isTaskCompleted
                            .where((e) => e == true)
                            .length +
                        dailyRecord.isDailyTaskCompleted
                            .where((e) => e == true)
                            .length;
                    final int totalTasks =
                        dailyRecord.isTaskCompleted.length +
                        dailyRecord.isDailyTaskCompleted.length;
                    taskPercentForDate = totalTasks > 0
                        ? completedTasks / totalTasks
                        : 0;
                  }

                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: () {
                        // update provider
                        globalState.setSelectedDate(date);
                      },
                      child: CircleAvatar(
                        backgroundColor: isSelected
                            ? Colors.black12
                            : Colors.transparent,
                        child: isCurrentMonth && dailyRecord != null
                            ? DayProgressCircularBar(
                                date: date.day.toString(),
                                habitPercent: habitPercentForDate,
                                taskPercent: taskPercentForDate,
                              )
                            : Text(
                                date.day.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: isCurrentMonth
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _monthName(int monthNumber) {
    return [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ][monthNumber - 1];
  }
}
