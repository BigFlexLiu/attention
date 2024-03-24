import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/problem_solution_provider.dart';

class ProblemSolutions extends StatelessWidget {
  const ProblemSolutions({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ProblemSolutionProvider(),
        builder: (context, child) => const ProblemSolutionList());
  }
}

class ProblemSolutionList extends StatefulWidget {
  const ProblemSolutionList({super.key});

  @override
  State<ProblemSolutionList> createState() => _ProblemSolutionListState();
}

class _ProblemSolutionListState extends State<ProblemSolutionList> {
  @override
  Widget build(BuildContext context) {
    final problemSolutions =
        Provider.of<ProblemSolutionProvider>(context).problemSolutions;
    return ListView(
      children: [
        for (int i = 0; i < problemSolutions.length; i++)
          ProblemSolutionCard(problemSolutions[i]),
        ProblemSolutionCreator((ProblemSolutionModel problemSolution) {
          setState(() {
            Provider.of<ProblemSolutionProvider>(context, listen: false)
                .addProblemSolution(problemSolution);
          });
        }),
      ],
    );
  }
}

class ProblemSolutionCard extends StatefulWidget {
  const ProblemSolutionCard(this.problemSolution, {super.key});
  final ProblemSolutionModel problemSolution;
  @override
  State<ProblemSolutionCard> createState() => _ProblemSolutionCardState();
}

class _ProblemSolutionCardState extends State<ProblemSolutionCard> {
  bool editting = false;

  @override
  Widget build(BuildContext context) {
    if (editting) {
      return ProblemSolutionEdittor(widget.problemSolution, () {
        setState(() {
          editting = false;
        });
      });
    }
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.album),
              title: Text(widget.problemSolution.problem),
              subtitle: Text(widget.problemSolution.solution),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              TextButton(
                child: const Text('Edit'),
                onPressed: () {
                  setState(() {
                    editting = true;
                  });
                },
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('Delete'),
                onPressed: () {
                  setState(() {
                    Provider.of<ProblemSolutionProvider>(context, listen: false)
                        .removeProblemSolution(widget.problemSolution);
                  });
                },
              ),
              const SizedBox(width: 8),
            ]),
          ],
        ),
      ),
    );
  }
}

class ProblemSolutionCreator extends StatefulWidget {
  const ProblemSolutionCreator(this.onAddProblemSolution, {super.key});
  final Function(ProblemSolutionModel) onAddProblemSolution;

  @override
  State<ProblemSolutionCreator> createState() => _ProblemSolutionCreatorState();
}

class _ProblemSolutionCreatorState extends State<ProblemSolutionCreator> {
  final TextEditingController _problemController = TextEditingController();
  final TextEditingController _solutionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.album),
              title: TextField(
                controller: _problemController,
                decoration: const InputDecoration(
                  hintText: 'Problem',
                ),
              ),
              subtitle: TextField(
                controller: _solutionController,
                decoration: const InputDecoration(
                  hintText: 'Solution',
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              TextButton(
                child: const Text('Add'),
                onPressed: () {
                  widget.onAddProblemSolution(ProblemSolutionModel(
                      _problemController.text, _solutionController.text));
                },
              ),
              const SizedBox(width: 8),
            ]),
          ],
        ),
      ),
    );
  }
}

class ProblemSolutionEdittor extends StatefulWidget {
  const ProblemSolutionEdittor(this.problemSolution, this.onCompleted,
      {super.key});
  final ProblemSolutionModel problemSolution;
  final VoidCallback onCompleted;

  @override
  State<ProblemSolutionEdittor> createState() => _ProblemSolutionEdittorState();
}

class _ProblemSolutionEdittorState extends State<ProblemSolutionEdittor> {
  final TextEditingController _problemController = TextEditingController();
  final TextEditingController _solutionController = TextEditingController();

  @override
  void initState() {
    _problemController.text = widget.problemSolution.problem;
    _solutionController.text = widget.problemSolution.solution;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.album),
              title: TextField(
                controller: _problemController,
                decoration: const InputDecoration(
                  hintText: 'Problem',
                ),
              ),
              subtitle: TextField(
                controller: _solutionController,
                decoration: const InputDecoration(
                  hintText: 'Solution',
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              TextButton(
                child: const Text('Add'),
                onPressed: () {
                  Provider.of<ProblemSolutionProvider>(context, listen: false)
                      .updateProblemSolution(
                          widget.problemSolution,
                          ProblemSolutionModel(_problemController.text,
                              _solutionController.text));
                  widget.onCompleted();
                },
              ),
              const SizedBox(width: 8),
            ]),
          ],
        ),
      ),
    );
  }
}
