import 'package:flutter/foundation.dart';

class ProblemSolutionProvider extends ChangeNotifier {
  final List<ProblemSolutionModel> _problemSolutions = [];
  List<ProblemSolutionModel> get problemSolutions => _problemSolutions;

  void addProblemSolution(ProblemSolutionModel problemSolution) {
    _problemSolutions.add(problemSolution);
    notifyListeners();
  }

  void removeProblemSolution(ProblemSolutionModel problemSolution) {
    _problemSolutions.remove(problemSolution);
    notifyListeners();
  }

  void updateProblemSolution(ProblemSolutionModel oldProblemSolution,
      ProblemSolutionModel newProblemSolution) {
    _problemSolutions[_problemSolutions.indexOf(oldProblemSolution)] =
        newProblemSolution;
    notifyListeners();
  }
}

class ProblemSolutionModel {
  final String problem;
  final String solution;

  ProblemSolutionModel(this.problem, this.solution);
}
