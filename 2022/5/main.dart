import 'dart:io';

extension CloneCloneable<T extends Cloneable<T>> on List<T> {
  List<T> clone() {
    return this.map((e) => e.clone()).toList();
  }
}

extension Clone<T> on List<T> {
  List<T> clone() {
    return this.map((e) => e).toList();
  }
}

abstract class Cloneable<T> {
  T clone();
}

// https://stackoverflow.com/questions/64060944/how-to-implement-a-stack-with-push-and-pop-in-dart/64060945#64060945
class Stack<E> implements Cloneable<Stack<E>> {
  final List<E> _list;

  Stack([List<E>? list]) : _list = list ?? <E>[];

  void push(E value) => _list.add(value);

  void pushMany(List<E> value) => _list.addAll(value);

  void pushFirst(E value) => _list.insert(0, value);

  E pop() {
    return _list.removeLast();
  }

  // Respects order
  List<E> takeTopN(int n) {
    return [
      for (int i = 0; i < n; ++i) pop(),
    ].reversed.toList();
  }

  E get peek {
    return _list.last;
  }

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();

  @override
  Stack<E> clone() {
    return Stack(_list.clone());
  }
}

class MoveCommand implements Cloneable<MoveCommand> {
  final int from;
  final int count;
  final int to;

  MoveCommand(this.from, this.count, this.to);

  factory MoveCommand.parseLine(String line) {
    final words = line.split(' ');
    final count = int.parse(words[1]);
    final from = int.parse(words[3]) - 1;
    final to = int.parse(words[5]) - 1;
    return MoveCommand(from, count, to);
  }

  @override
  MoveCommand clone() {
    return MoveCommand(from, count, to);
  }
}

void first(List<Stack<String>> stacks, List<MoveCommand> commands) {
  for (final command in commands) {
    for (int i = 0; i < command.count; ++i) {
      stacks[command.to].push(stacks[command.from].pop());
    }
  }

  String buffer = '';
  for (final stack in stacks) {
    late String top;
    try {
      top = stack.peek;
    } catch (_) {
      top = '';
    }

    buffer = '$buffer$top';
  }
  print(buffer);
}

void second(List<Stack<String>> stacks, List<MoveCommand> commands) {
  for (final command in commands) {
    stacks[command.to].pushMany(stacks[command.from].takeTopN(command.count));
  }

  String buffer = '';
  for (final stack in stacks) {
    late String top;
    try {
      top = stack.peek;
    } catch (_) {
      top = '';
    }

    buffer = '$buffer$top';
  }
  print(buffer);
}

const stackCount = 32;

void main(List<String> args) {
  const day = 5;

  final lines =
      File('${Directory.current.path}/2022/$day/input.txt').readAsLinesSync();

  final stacks = List.generate(stackCount, (_) => Stack<String>());

  final stackLines = lines
      .takeWhile((value) => value.isNotEmpty && !value.startsWith(' 1'))
      .toList();

  final stackMatcher = RegExp(r'(\[[A-Z]\] ?| {3} ?)');

  stackLines.forEach((line) {
    final matches = stackMatcher.allMatches(line).toList();
    for (var i = 0; i < 9; ++i) {
      final match = matches.elementAt(i).group(0);
      if (match!.trim().isNotEmpty) {
        stacks[i].pushFirst(match[1]);
      }
    }
  });

  lines.removeRange(0, stackLines.length + 2);

  final commands = lines.map((e) => MoveCommand.parseLine(e)).toList();

  first(stacks.clone(), commands.clone());
  second(stacks.clone(), commands.clone());
}
