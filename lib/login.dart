import 'package:attention/provider/all_tasks_provider.dart';
import 'package:attention/provider/hangedNotesProvider.dart';
import 'package:attention/provider/settings_provider.dart';
import 'package:attention/provider/task_provider.dart';
import 'package:attention/util/util.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'io/notes_io.dart';
import 'load_on_start.dart';

class TimeStorage {
  static const String _key = 'currentTime';

  // Save the current time to SharedPreferences
  static Future<void> saveCurrentTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime currentTime = DateTime.now();
    String currentTimeString = currentTime.toString();
    await prefs.setString(_key, currentTimeString);
  }

  // Load the saved time from SharedPreferences
  static Future<DateTime?> loadCurrentTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedTimeString = prefs.getString(_key);
    if (savedTimeString != null) {
      return DateTime.parse(savedTimeString);
    }
    return null; // Return null if no time was saved previously
  }
}

Future<Initializer> login() async {
  final lastLogin = await TimeStorage.loadCurrentTime();
  TimeStorage.saveCurrentTime();

  // Load data
  await checkFirstLaunchAndUpdate(); // Check and update launch status

  final hangedNotesProvider = HangedNotesProvider();
  final taskProvider = TaskProvider();
  final settingsProvider = SettingsProvider();
  final AllTasksProvider allTasksProvider = AllTasksProvider();
  await Future.wait([
    hangedNotesProvider.pullHangedNotes(),
    taskProvider.init(),
    settingsProvider.init(),
    allTasksProvider.init(),
  ]);

  final Initializer initializer = Initializer(
    hangedNotesProvider: hangedNotesProvider,
    taskProvider: taskProvider,
    settingsProvider: settingsProvider,
    allTasksProvider: allTasksProvider,
    lastLogin: lastLogin,
  );

  createTempNote(initializer);

  return initializer;
}

// Create a temperary note by looking at recent data
Future<void> createTempNote(Initializer initializer) async {
  final oneDayFromNow = DateTime.now().add(const Duration(days: 1));
  // Create welcome note the removes itself after a day on first login
  if (initializer.lastLogin == null) {
    final tempNote = await addSimpleNote(
      'Welcome to Attention!',
      """This app is designed to help you better complete your goals by defining them.
The task definition is focused on creating small tasks that can be completed quickly.
The notes are there to help you plan ahead, you can also hang them like this note.
      
The goal of this app is to help you overcome many common barriers to productivity, such as:
- Lack of clear goals
- Overly large task scope
- Distractions
      
We hope this app will help you in any way, big or small!
      """,
    );

    editSimpleNoteById(
        tempNote.id, tempNote.title, tempNote.content, oneDayFromNow);

    initializer.hangedNotesProvider.hangNote(tempNote, oneDayFromNow);
    return;
  }

  final dayOfLastLogin = dayOf(initializer.lastLogin!);

  final oneDaySinceLogin =
      dayOfLastLogin.add(const Duration(days: 1)).compareTo(dayOf(DateTime.now()));

  assert(oneDaySinceLogin != -1);
  if (oneDaySinceLogin == 1) {
    return;
  }

  // Create a one day note summary of last work day's tasks
  final tasksFromYesterday =
      initializer.allTasksProvider.tasks.where((element) {
    final oneDaySinceTask = dayOf(element.startTime!).add(const Duration(days: 1));

    return oneDaySinceTask.compareTo(dayOf(initializer.lastLogin!)) == 0;
  });

  final completedTasks =
      tasksFromYesterday.where((element) => element.completed);
  final incompleteTasks =
      tasksFromYesterday.where((element) => !element.completed);

  String taskSummary = completedTasks.fold<String>(
    "Last time you have completed:\n",
    (previousValue, element) => "$previousValue- ${element.title}\n",
  );

  taskSummary += incompleteTasks.fold<String>(
    "\nYou have also started:\n",
    (previousValue, element) => "$previousValue- ${element.title}\n",
  );

  final lastloginADayAgo = dayOf(initializer.lastLogin!.add(const Duration(days: 1)))
      .compareTo(dayOf(DateTime.now()));
  final lastLoginDateName = lastloginADayAgo == 0
      ? 'Yesterday'
      : DateFormat("dd LLLL, yyyy").format(initializer.lastLogin!);
  final tempNote = await addSimpleNote(
    '{lastLoginDateName}\'s Task Summary',
    taskSummary,
  );

  editSimpleNoteById(
    tempNote.id,
    tempNote.title,
    tempNote.content,
    oneDayFromNow,
  );

  initializer.hangedNotesProvider.hangNote(tempNote, oneDayFromNow);

  return;
}

class Initializer {
  final HangedNotesProvider hangedNotesProvider;
  final TaskProvider taskProvider;
  final SettingsProvider settingsProvider;
  final AllTasksProvider allTasksProvider;
  final DateTime? lastLogin;

  Initializer({
    required this.hangedNotesProvider,
    required this.taskProvider,
    required this.settingsProvider,
    required this.allTasksProvider,
    this.lastLogin,
  });
}
