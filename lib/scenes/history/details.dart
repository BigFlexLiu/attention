import 'package:attention/scenes/history/reflectionDetail.dart';
import 'package:attention/scenes/history/steps.dart';
import 'package:flutter/material.dart';

import '../../models/task.dart';
import 'importance.dart';

class DetailTabs extends StatefulWidget {
  DetailTabs(this.task, {super.key});
  Task task;

  @override
  State<DetailTabs> createState() => _DetailTabsState();
}

class _DetailTabsState extends State<DetailTabs> with TickerProviderStateMixin {
  TabController? _tabController;
  final Map<String, Widget> _tabs = {};

  @override
  void initState() {
    super.initState();
    if (widget.task.steps.isNotEmpty) {
      _tabs['Steps'] = StepsHistory(widget.task.steps);
    }
    if (widget.task.personalImportance.isNotEmpty) {
      _tabs['Importance'] = ImportanceHistory(widget.task.personalImportance);
    }
    if (widget.task.reflectionAnswer.isNotEmpty) {
      _tabs['Reflection'] = ReflectionDetails(widget.task);
    }

    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_tabs.isEmpty) {
      return Container();
    }
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        // Other list items here
        Container(
          child: TabBar(
              controller: _tabController,
              tabs: _tabs.keys.map((e) => Text(e)).toList()),
        ),
        SizedBox(
          height: 200, // Adjust the height according to your need
          child: TabBarView(
            controller: _tabController,
            children: _tabs.values.toList(),
          ),
        ),
        // More list items can follow
      ],
    );
  }
}
