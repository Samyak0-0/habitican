import 'package:flutter/material.dart';
import 'package:habitican/utils/global_state_provider.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final testStr = Provider.of<GlobalStateProvider>(context);
    print(testStr.testString);
    return ListView(
      children: [
        Text('Profile'),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('name'),
                  Text('email'),
                ],
              ),
            ),
            Icon(Icons.account_circle),
            Icon(Icons.navigate_next),
          ],
        ),
        Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Current Streaks'),
                      Icon(Icons.fireplace),
                    ],
                  ),
                  Text("Streak - 1"),
                  Text("Streak - 2"),
                  Text("Streak - 3"),
                  Text(" . . . "),
                ],
              ),
            ),
            Icon(Icons.navigate_next),
          ],
        ),
        Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Best Streaks: '),
                      Icon(Icons.fireplace),
                    ],
                  ),
                  Text("Streak - 1"),
                  Text("Streak - 2"),
                  Text("Streak - 3"),
                  Text(" . . . "),
                ],
              ),
            ),
            Icon(Icons.navigate_next),
          ],
        ),
        Text('Badges'),
        Row(
          children: [
            Icon(Icons.flag_circle),
            Icon(Icons.run_circle),
            Icon(Icons.cloud_circle),
          ],
        ),
        Text('Settings'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Personal Information'),
            Icon(Icons.navigate_next),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Notifications'),
            Text('On/Off'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Theme'),
            Icon(Icons.dark_mode),
          ],
        ),
        Text('Reset Data'),
        Text('Log Out'),
      ],
    );
  }
}
