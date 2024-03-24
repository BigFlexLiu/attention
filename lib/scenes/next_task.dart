import 'package:attention/scenes/problem_solution.dart';
import 'package:attention/scenes/task_breakdown.dart';
import 'package:attention/scenes/time_setter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/task_provider.dart';

class NextTask extends StatefulWidget {
  const NextTask({Key? key}) : super(key: key);

  @override
  State<NextTask> createState() => _NextTaskState();
}

class _NextTaskState extends State<NextTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPagePresenter(pages: [
        TaskQuestionModel(
          title: 'Define',
          description: 'What do you want to achieve?',
          hint: "Be specific and clear",
          imageUrl: 'https://i.ibb.co/cJqsPSB/scooter.png',
          inputWidget: TextField(
            decoration: const InputDecoration(hintText: "Be concise"),
            onChanged: (value) {
              Provider.of<TaskProvider>(context, listen: false)
                  .setTaskTitle(value);
            },
          ),
          bgColor: Colors.indigo,
        ),
        TaskQuestionModel(
          title: 'Bound',
          description: 'How long would you like to work this session?',
          hint:
              "Keep in mind of how long you can focus for. 25 minutes is a good start.",
          imageUrl: 'https://i.ibb.co/LvmZypG/storefront-illustration-2.png',
          inputWidget: const TimeSetter(),
          bgColor: const Color(0xff1eb090),
        ),
        TaskQuestionModel(
          title: 'Steps',
          description: 'How do you break this task down into simpler steps?',
          hint: "Keep in mind of the ordering of the steps",
          imageUrl: 'https://i.ibb.co/420D7VP/building.png',
          inputWidget: const TaskBreakdown(),
          bgColor: const Color(0xfffeae4f),
        ),
        TaskQuestionModel(
          title: 'Reflect',
          description: 'Why is important for you to complete this task?',
          hint: "Be honest, the more personal the better.",
          imageUrl: 'https://i.ibb.co/cJqsPSB/scooter.png',
          inputWidget: TextField(
            decoration:
                const InputDecoration(hintText: "Be specific and clear"),
            maxLines: null,
            onChanged: (value) {
              Provider.of<TaskProvider>(context, listen: false)
                  .setTaskPersonalImportance(value);
            },
          ),
          bgColor: Colors.purple,
        ),
        TaskQuestionModel(
          title: 'Prevent',
          description: 'What problem might disrupt you?',
          hint: "Anticipate and plan for the worst.",
          imageUrl: 'https://i.ibb.co/cJqsPSB/scooter.png',
          inputWidget: const ProblemSolutions(),
          bgColor: Colors.purple,
        ),
        TaskQuestionModel(
          title: 'Promise',
          description: 'What should be the reward for completing this task?',
          hint: "What do you enjoy doing? It could also be a small treat.",
          imageUrl: 'https://i.ibb.co/cJqsPSB/scooter.png',
          inputWidget: TextField(
            decoration:
                const InputDecoration(hintText: "Be specific and clear"),
            maxLines: null,
            onChanged: (value) {
              Provider.of<TaskProvider>(context, listen: false)
                  .setTaskReward(value);
            },
          ),
          bgColor: Colors.purple,
        ),
      ]),
    );
  }
}

class OnboardingPagePresenter extends StatefulWidget {
  final List<TaskQuestionModel> pages;
  final VoidCallback? onSkip;
  final VoidCallback? onFinish;

  const OnboardingPagePresenter(
      {Key? key, required this.pages, this.onSkip, this.onFinish})
      : super(key: key);

  @override
  State<OnboardingPagePresenter> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPagePresenter> {
  // Store the currently visible page
  int _currentPage = 0;
  // Define a controller for the pageview
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: widget.pages[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                // Pageview to render each page
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pages.length,
                  onPageChanged: (idx) {
                    // Change current page when pageview changes
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = widget.pages[idx];
                    return Column(
                      children: [
                        Expanded(
                            child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(item.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: item.textColor,
                                            )),
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text("Hint"),
                                                  content: Text(item.hint),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text('Close'),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        icon: Icon(Icons.help,
                                            color: invertColor(item.textColor)))
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: item.inputWidget,
                            ),
                          )
                        ])),
                      ],
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
              SizedBox(
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
                      onPressed: () {
                        if (_currentPage == widget.pages.length - 1) {
                          widget.onFinish?.call();
                        } else {
                          _pageController.animateToPage(_currentPage + 1,
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(milliseconds: 250));
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TaskQuestionModel {
  final String title;
  final String description;
  final String hint;
  final String imageUrl;
  final Widget inputWidget;
  final Color bgColor;
  final Color textColor;

  TaskQuestionModel(
      {required this.title,
      required this.description,
      required this.hint,
      required this.imageUrl,
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
