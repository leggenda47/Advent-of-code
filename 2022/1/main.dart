import 'dart:io';

extension on Iterable<int> {
  int sum() {
    return fold(0, (acc, cur) => acc + cur);
  }
}

void first(List<String> lines) {
  int maxCalories = 0;
  int currentCalories = 0;
  for (final line in lines) {
    if (line.isEmpty) {
      if (currentCalories > maxCalories) {
        maxCalories = currentCalories;
      }
      currentCalories = 0;
      continue;
    }

    final current = int.parse(line);
    currentCalories += current;
  }
  print(maxCalories);
}

void second(List<String> lines) {
  final maxCalories = <int>[0];
  int currentCalories = 0;
  for (final line in lines) {
    if (line.isEmpty) {
      maxCalories.add(currentCalories);
      currentCalories = 0;
      continue;
    }

    final current = int.parse(line);
    currentCalories += current;
  }
  maxCalories.sort((a, b) => b.compareTo(a));

  print(maxCalories.take(3).sum());
}

void main(List<String> args) {
  final lines = File('./input.txt').readAsLinesSync();

  first(lines);
  second(lines);
}
