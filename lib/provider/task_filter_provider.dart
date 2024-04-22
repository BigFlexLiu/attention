import 'package:flutter/cupertino.dart';

import '../models/task.dart';

class TaskFilterProvider extends ChangeNotifier {
  Filter _filter = Filter(TaskStatusFilter.all, null, null);

  Filter get filter => _filter;

  void setTaskStatusFilter(TaskStatusFilter taskStatusFilter) {
    _filter = Filter(taskStatusFilter, _filter.startTime, _filter.endTime);
    notifyListeners();
  }

  void setTimeBoundFilter(DateTime? startTime, DateTime? endTime) {
    _filter = Filter(_filter.taskStatusFilter, startTime, endTime);
    notifyListeners();
  }

  List<Task> filterTasks(List<Task> tasks) {
    return _filter.filterTasks(tasks);
  }
}

enum TaskStatusFilter {
  all,
  completed,
  incomplete,
}

class Filter {
  TaskStatusFilter taskStatusFilter;
  DateTime? startTime;
  DateTime? endTime;

  Filter(this.taskStatusFilter, this.startTime, this.endTime);

  Filter.copy(Filter filter)
      : taskStatusFilter = filter.taskStatusFilter,
        startTime = filter.startTime,
        endTime = filter.endTime;

  filterByStatus(List<Task> tasks) {
    return tasks.where((task) {
      if (taskStatusFilter == TaskStatusFilter.all) {
        return true;
      } else if (taskStatusFilter == TaskStatusFilter.completed) {
        return task.completed;
      } else {
        return !task.completed;
      }
    }).toList();
  }

  filterByTime(List<Task> tasks) {
    return tasks.where((task) {
      if (startTime == null && endTime == null) {
        return true;
      }
      return task.startTime!.isAfter(startTime!) &&
          task.startTime!.isBefore(endTime!);
    }).toList();
  }

  filterTasks(List<Task> tasks) {
    return filterByStatus(filterByTime(tasks));
  }
}
