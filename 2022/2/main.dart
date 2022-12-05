import 'dart:io';

const options = ['A', 'B', 'C'];

String translateSelection(String a) {
  if (a == 'X') return 'A';
  if (a == 'Y') return 'B';
  if (a == 'Z') return 'C';

  throw ArgumentError.value(a, 'a', 'Is not X, Y or Z');
}

String translateCommand(String them, String command) {
  final theirIndex = options.indexOf(them);
  int myIndex = -1;

  if (command == 'X') myIndex = theirIndex - 1;
  if (command == 'Y') myIndex = theirIndex;
  if (command == 'Z') myIndex = theirIndex + 1;

  return options[myIndex % 3];
}

int outcomeScore(String them, String me) {
  final theirIndex = options.indexOf(them);
  final myIndex = options.indexOf(me);

  if (them == me) {
    return 3;
  }

  if ((theirIndex + 1) % 3 == myIndex) {
    return 6;
  }

  return 0;
}

int selectionScore(String selection) {
  return options.indexOf(selection) + 1;
}

int calculateScore(String them, String me) {
  return selectionScore(me) + outcomeScore(them, me);
}

void first(List<String> lines) {
  int finalScore = 0;
  for (final line in lines) {
    final split = line.split(' ');
    final them = split[0];
    final me = translateSelection(split[1]);

    finalScore += calculateScore(them, me);
  }

  print(finalScore);
}

void second(List<String> lines) {
  int finalScore = 0;
  for (final line in lines) {
    final split = line.split(' ');
    final them = split[0];
    final me = translateCommand(them, split[1]);

    finalScore += calculateScore(them, me);
  }

  print(finalScore);
}

void main(List<String> args) {
  final lines = File('./input.txt').readAsLinesSync();

  first(lines);
  second(lines);
}
