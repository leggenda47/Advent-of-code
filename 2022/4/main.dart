import 'dart:io';

class Pair<T> {
  final T left;
  final T right;

  Pair(this.left, this.right);
}

void first(List<Pair<Pair<int>>> pairs) {
  int fullyOverlayCount = 0;
  for (final sections in pairs) {
    if (sections.left.left <= sections.right.left &&
            sections.left.right >= sections.right.right ||
        sections.right.left <= sections.left.left &&
            sections.right.right >= sections.left.right) {
      fullyOverlayCount += 1;
    }
  }
  print(fullyOverlayCount);
}

void second(List<Pair<Pair<int>>> pairs) {
  int fullyOverlayCount = 0;
  for (final sections in pairs) {
    if (sections.left.left >= sections.right.left &&
            sections.left.left <= sections.right.right ||
        sections.left.right <= sections.right.right &&
            sections.left.right >= sections.right.left ||
        sections.right.left >= sections.left.left &&
            sections.right.left <= sections.left.right ||
        sections.right.right <= sections.left.right &&
            sections.right.right >= sections.left.left) {
      fullyOverlayCount += 1;
    }
  }
  print(fullyOverlayCount);
}

void main(List<String> args) {
  const day = 4;

  final lines =
      File('${Directory.current.path}/2022/$day/input.txt').readAsLinesSync();

  final pairs = lines.map((line) {
    final sectionPairs = line.split(',');
    final leftSections = sectionPairs.first.split('-');
    final rightSections = sectionPairs.last.split('-');
    return Pair(
      Pair(int.parse(leftSections[0]), int.parse(leftSections[1])),
      Pair(int.parse(rightSections[0]), int.parse(rightSections[1])),
    );
  }).toList();

  first(pairs);
  second(pairs);
}
