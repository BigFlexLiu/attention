import 'package:attention/provider/settings_provider.dart';
import 'package:attention/scenes/create_task/problem_solution.dart';
import 'package:attention/scenes/create_task/task_breakdown.dart';
import 'package:attention/scenes/create_task/time_setter.dart';
import 'package:attention/scenes/current_task/ongoing_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/task_provider.dart';
import '../../theme/circle_painter.dart';
import '../../theme/theme.dart';
import '../../util/services.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({this.isDemo = false, Key? key}) : super(key: key);
  final bool isDemo;

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  late String initialTitle;
  late String initialPersonalImportance;
  late String initialReward;

  @override
  void initState() {
    final task = Provider.of<TaskProvider>(context, listen: false).task;
    initialTitle = task.title;
    initialPersonalImportance = task.personalImportance;
    initialReward = task.reward;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskDefinition =
        Provider.of<SettingsProvider>(context).settings.taskDefinition;
    return Scaffold(
      body: OnboardingPagePresenter(isDemo: widget.isDemo, pages: [
        TaskQuestionModel(
          title: 'Define',
          description: 'What do you want to achieve?',
          hint: null,
          inputWidget: TextField(
            controller: TextEditingController()..text = initialTitle,
            decoration:
                const InputDecoration(hintText: "Be specific and concise"),
            onChanged: (value) {
              Provider.of<TaskProvider>(context, listen: false)
                  .setTaskTitle(value);
            },
          ),
          bgColor: taskComponentColors["title"]!,
        ),
        TaskQuestionModel(
          title: 'Bound',
          description: 'How long would you like to work this session?',
          hint:
              "Keep in mind of how long you can focus for. 25 minutes is a good start.",
          inputWidget: const TimeSetter(),
          bgColor: taskComponentColors["time"]!,
        ),
        if (taskDefinition.defineSteps)
          TaskQuestionModel(
            title: 'Steps',
            description: 'How do you break this task down into simpler steps?',
            hint:
                "Break it down into smaller tasks to make it more manageable.",
            inputWidget: const TaskBreakdown(),
            bgColor: taskComponentColors["steps"]!,
          ),
        if (taskDefinition.defineReflect)
          TaskQuestionModel(
            title: 'Reflect',
            description: 'Why is it important for you to complete this task?',
            hint:
                "A strong reason is a good motivator, especially a personal one.",
            inputWidget: TextField(
              controller: TextEditingController()
                ..text = initialPersonalImportance,
              decoration:
                  const InputDecoration(hintText: "Be specific and clear"),
              maxLines: null,
              onChanged: (value) {
                Provider.of<TaskProvider>(context, listen: false)
                    .setTaskPersonalImportance(value);
              },
            ),
            bgColor: taskComponentColors["personalImportance"]!,
          ),
        if (taskDefinition.defineProblems)
          TaskQuestionModel(
            title: 'Prevent',
            description: 'What problem might disrupt you?',
            hint:
                "What problem have you encountered before doing a similar task?",
            inputWidget: const ProblemSolutions(),
            bgColor: taskComponentColors["problemSolutions"]!,
          ),
        if (taskDefinition.definePromise)
          TaskQuestionModel(
            title: 'Promise',
            description: 'What should be the reward for completing this task?',
            hint: "What do you enjoy doing? It could also be a small treat.",
            inputWidget: TextField(
              controller: TextEditingController()..text = initialReward,
              decoration:
                  const InputDecoration(hintText: "Be kind to yourself"),
              maxLines: null,
              onChanged: (value) {
                Provider.of<TaskProvider>(context, listen: false)
                    .setTaskReward(value);
              },
            ),
            bgColor: taskComponentColors["promise"]!,
          ),
      ]),
    );
  }
}

class OnboardingPagePresenter extends StatefulWidget {
  final List<TaskQuestionModel> pages;
  final bool isDemo;

  const OnboardingPagePresenter(
      {this.isDemo = false, Key? key, required this.pages})
      : super(key: key);

  @override
  State<OnboardingPagePresenter> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPagePresenter> {
  // Store the currently visible page
  int _currentPage = 0;
  // Define a controller for the pageview
  final PageController _pageController = PageController(initialPage: 0);

  SnackBar? _currentSnackBar;

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<TaskProvider>(context).task;
    // Returns whether the page change was successful
    bool shouldPageChange() {
      if (widget.isDemo) return true;
      if (_currentPage == 0 && task.title.isEmpty) {
        _showSnackBar(context, "Please enter a title");
        return false;
      }
      if (_currentPage == 1 && task.duration == Duration.zero) {
        _showSnackBar(context, "A task should not be 0s long");
        return false;
      }
      return true;
    }

    if (_currentPage >= widget.pages.length) {
      _currentPage = widget.pages.length - 1;
    }

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: widget.pages[_currentPage].bgColor,
        child: SafeArea(
          child: CustomPaint(
            painter: CirclePainter(),
            child: Column(
              children: [
                Expanded(
                  // Pageview to render each page
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.pages.length,
                    onPageChanged: (idx) {
                      if (shouldPageChange()) {
                        setState(() {
                          _currentPage = idx;
                        });
                      } else {
                        _pageController.animateToPage(_currentPage,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      }
                    },
                    itemBuilder: (context, idx) {
                      final item = widget.pages[idx];
                      return IgnorePointer(
                        ignoring: widget.isDemo,
                        child: Column(
                          children: [
                            Expanded(
                                child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(item.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: item.textColor,
                                                )),
                                        if (item.hint != null)
                                          IconButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title:
                                                            const Text("Hint"),
                                                        content:
                                                            Text(item.hint!),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'Close'),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                              icon: Icon(Icons.help,
                                                  color: invertColor(
                                                      item.textColor)))
                                      ],
                                    ),
                                    Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 280),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0, vertical: 8.0),
                                      child: Text(item.description,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: item.textColor,
                                              )),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  child: item.inputWidget,
                                ),
                              )
                            ])),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Current page indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.pages
                      .map((item) => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: _currentPage == widget.pages.indexOf(item)
                                ? 30
                                : 8,
                            height: 8,
                            margin: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0)),
                          ))
                      .toList(),
                ),

                // Bottom buttons
                IgnorePointer(
                  ignoring: widget.isDemo,
                  child: SizedBox(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                              visualDensity: VisualDensity.comfortable,
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          onPressed: () {
                            if (_currentPage == 0) {
                              Navigator.pop(context);
                            } else {
                              _pageController.animateToPage(_currentPage - 1,
                                  curve: Curves.easeInOutCubic,
                                  duration: const Duration(milliseconds: 250));
                            }
                          },
                          child: Row(
                            children: [
                              Icon(_currentPage == 0
                                  ? Icons.home
                                  : Icons.arrow_back),
                              const SizedBox(width: 8),
                              const Text("Back"),
                            ],
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              visualDensity: VisualDensity.comfortable,
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            if (_currentPage == widget.pages.length - 1) {
                              Provider.of<TaskProvider>(context, listen: false)
                                  .setTaskStartTime(DateTime.now());

                              final durationInSeconds =
                                  Provider.of<TaskProvider>(context,
                                          listen: false)
                                      .task
                                      .duration!
                                      .inSeconds;
                              PlatformService.startService(durationInSeconds);

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const OnGoingTask()));
                            } else {
                              if (shouldPageChange()) {
                                _pageController.animateToPage(_currentPage + 1,
                                    curve: Curves.easeInOutCubic,
                                    duration:
                                        const Duration(milliseconds: 250));
                              }
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                _currentPage == widget.pages.length - 1
                                    ? "Start"
                                    : "Next",
                              ),
                              const SizedBox(width: 8),
                              Icon(_currentPage == widget.pages.length - 1
                                  ? Icons.done
                                  : Icons.arrow_forward),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    if (_currentSnackBar != null) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
    }
    _currentSnackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(_currentSnackBar!);
  }
}

class TaskQuestionModel {
  final String title;
  final String description;
  final String? hint;
  final Widget inputWidget;
  final Color bgColor;
  final Color textColor;

  TaskQuestionModel(
      {required this.title,
      required this.description,
      required this.hint,
      required this.inputWidget,
      this.bgColor = Colors.blue,
      this.textColor = Colors.white});
}

Color invertColor(Color color) {
  int r = 255 - color.red;
  int g = 255 - color.green;
  int b = 255 - color.blue;
  return Color.fromRGBO(r, g, b, color.opacity);
}
