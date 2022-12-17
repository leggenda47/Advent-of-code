import 'dart:io';

void first(List<String> pairs) {}

void second(List<String> pairs) {}

void main(List<String> args) {
  const day = -1;

  final lines =
      File('${Directory.current.path}/2022/$day/input.txt').readAsLinesSync();

  first(lines);
  second(lines);
}
