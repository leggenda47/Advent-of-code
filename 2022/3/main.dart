import 'dart:io';

final unita = 'a'.codeUnitAt(0);
final lowercaseOffset = 1;

final unitA = 'A'.codeUnitAt(0);
final uppercaseOffset = 27;

extension on List<int> {
  List<Set<int>> halve() {
    final half = length ~/ 2;
    return [
      {...sublist(0, half)},
      {...sublist(half, length)},
    ];
  }
}

extension on int {
  int get rearrangePriority {
    if (this >= unita) {
      return this - unita + lowercaseOffset;
    } else if (this >= unitA) {
      return this - unitA + uppercaseOffset;
    }

    throw ArgumentError.value(this, 'this', 'invalid value');
  }
}

void first(List<String> lines) {
  int sumOfPriorities = 0;
  for (final line in lines) {
    final halves = line.codeUnits.halve();
    final intersection = halves[0].intersection(halves[1]);

    intersection.forEach((e) => sumOfPriorities += e.rearrangePriority);
  }
  print(sumOfPriorities);
}

void second(List<String> lines) {
  final iterator = lines.iterator;

  int sumOfBadgePriorities = 0;
  while (iterator.moveNext()) {
    final a = Set<int>.from(iterator.current.codeUnits);
    iterator.moveNext();
    final b = Set<int>.from(iterator.current.codeUnits);
    iterator.moveNext();
    final c = Set<int>.from(iterator.current.codeUnits);

    a.intersection(b.intersection(c)).forEach((e) {
      sumOfBadgePriorities += e.rearrangePriority;
    });
  }

  print(sumOfBadgePriorities);
}

void main(List<String> args) {
  final lines = File('./input.txt').readAsLinesSync();

  first(lines);
  second(lines);
}
