import 'package:attention/scenes/current_task/prevent.dart';
import 'package:attention/scenes/current_task/steps.dart';
import 'package:attention/scenes/current_task/timer.dart';
import 'package:flutter/material.dart';

import '../../theme/falling_circle_animator.dart';

class OnGoingTask extends StatefulWidget {
  const OnGoingTask({super.key});

  @override
  State<OnGoingTask> createState() => _OnGoingTaskState();
}

class _OnGoingTaskState extends State<OnGoingTask> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(_NavBarItems[_selectedIndex]["name"] as String),
        ),
        body: FallingCircleAnimator(
            child: _NavBarItems[_selectedIndex]["widget"] as Widget),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: 'Task',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Steps',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.warning),
              label: 'Problems',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ));
  }
}

final _NavBarItems = [
  {"name": "Timer", "widget": const TaskTimer()},
  {"name": "Steps", "widget": const Steps()},
  {"name": "Problems", "widget": const Prevent()},
];
