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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        // Other list items here
        Container(
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Steps'),
              Tab(text: 'Importance'),
              Tab(text: 'Reflection'),
            ],
          ),
        ),
        SizedBox(
          height: 200, // Adjust the height according to your need
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              StepsHistory(widget.task.steps),
              Center(child: ImportanceHistory(widget.task.personalImportance)),
              Center(child: ReflectionDetails(widget.task)),
            ],
          ),
        ),
        // More list items can follow
      ],
    );
  }
}
