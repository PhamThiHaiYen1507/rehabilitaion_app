import 'dart:async';

import 'package:async/async.dart';
import 'package:commons/commons.dart';
import 'package:finplus/utils/app_logger.dart';

class FutureTaskQueue<T> {
  final int parallel;

  final QueueList<_FutureTask<T>> _queue = QueueList();

  final List<_FutureTask<T>> _runningTask = [];

  bool _isRunning = false;

  FutureTaskQueue({this.parallel = 1});

  Future<void> _runTask() async {
    if (_queue.isEmpty) {
      _isRunning = false;
    } else {
      _isRunning = true;
      if (_runningTask.length >= parallel) return;

      final task = _queue.removeFirst();
      _runningTask.add(task);
      try {
        final result = await task.future();
        task.completer.complete(result);
      } catch (e, stackTrace) {
        logE(e, stackTrace);
      }
      _runningTask.remove(task);
      _runTask();
    }
  }

  Future<T>? getTaskId(String id) =>
      _queue.firstWhereOrNull((element) => element.id == id)?.completer.future;

  Future<T> add(Future<T> Function() future, [String? id]) {
    if (id != null) {
      final current = _queue.firstWhereOrNull((element) => element.id == id);
      if (current != null) {
        return current.completer.future;
      }
    }
    final Completer<T> completer = Completer();
    _queue.add(_FutureTask<T>(completer: completer, future: future));
    if (!_isRunning) {
      for (var i = 0; i < parallel; i++) {
        _runTask();
      }
    }

    return completer.future;
  }

  bool get isRunning => _isRunning;

  List<String?> get taskIds => _queue.map((element) => element.id).toList();

  void cancelAllTask() {
    while (_queue.isEmpty) {
      final current = _queue.removeFirst();
      final cancelableCompleter =
          CancelableOperation.fromFuture(current.future());
      cancelableCompleter.cancel();
    }
  }
}

class _FutureTask<T> {
  final String? id;
  final Completer<T> completer;
  final Future<T> Function() future;

  _FutureTask({
    required this.completer,
    required this.future,
    this.id,
  });
}
