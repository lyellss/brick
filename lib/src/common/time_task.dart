import 'dart:async';

import 'package:flutter/material.dart';

/// 有关时间的定时任务，轮询任务，计时任务

/// 定时任务 默认10s后执行
class TimePiece {
  Timer? _timer;

  void start(void Function() callback, {int seconds = 10}) {
    cancel();
    _timer = Timer(Duration(seconds: seconds), callback);
  }

  void cancel() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = null;
  }
}

/// 定时任务 默认10s后执行
class TimeClockPiece {
  Timer? _timer;

  bool _isRunning = false;

  bool get isRunning => _isRunning;

  void startOfSeconds(void Function() callback, {int seconds = 10}) {
    cancel();
    _timer = Timer(Duration(seconds: seconds), () {
      callback.call();
      _isRunning = false;
    });
    _isRunning = true;
  }

  void startOfMilliseconds(void Function() callback, {int milliseconds = 200}) {
    cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), () {
      callback.call();
      _isRunning = false;
    });
    _isRunning = true;
  }

  void cancel() {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = null;
  }
}

/// 循环任务
class TimePeriodic {
  Timer? _timer;

  TimePeriodic();

  /// [seconds] 循环周期
  void start(void Function() callback, {int seconds = 10}) {
    cancel();
    _timer = Timer.periodic(Duration(seconds: seconds), (timer) {
      callback();
    });
  }

  void cancel() {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = null;
  }
}

/// 倒计时
class TimeCountdown {
  Timer? _timer;

  late int _total;

  int _curSecond = 0;

  late int _remainSecond;

  bool _running = false;

  bool get running => _running;

  int get remainSecond => _remainSecond;

  int get curSecond => _curSecond;

  void start({
    required int totalSeconds,
    required ValueChanged<int> periodicCallback,
    VoidCallback? endCallback,
  }) {
    cancel();
    _curSecond = 0;
    _total = totalSeconds;
    _remainSecond = _total;
    _running = true;
    periodicCallback.call(_remainSecond);
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _curSecond++;
        if (_curSecond <= _total) {
          _remainSecond = _total - _curSecond;
          periodicCallback.call(_remainSecond);
        } else {
          _running = false;
          endCallback?.call();
          timer.cancel();
        }
      },
    );
  }

  void cancel() {
    _running = false;
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = null;
  }
}

/// 时间片计时
/// 用于计算某个任务花费的时间
class TimeWatcher {
  TimeWatcher();

  DateTime? _dateTime;

  void start() {
    _dateTime = DateTime.now();
  }

  Duration stop() {
    DateTime stopTime = DateTime.now();
    return stopTime.difference(_dateTime ?? stopTime);
  }
}

/// 防止连续点击
TimePressure singleTaper = TimePressure(const Duration(milliseconds: 1000));

typedef OnHit = void Function();

/// 时间压力限制
class TimePressure {
  int count = 0;

  /// 是否在压力时间内
  bool isEnduring = false;

  TimeWatcher? _watcher;

  /// 压力时间
  final Duration pressure;

  TimePressure([this.pressure = const Duration(milliseconds: 3000)]);

  void hit(OnHit onHit) {
    if (_watcher == null) {
      onHit.call();
      _watcher = TimeWatcher();
      _watcher!.start();
      isEnduring = true;
      count += 1;
      return;
    }

    Duration piece = _watcher!.stop();
    if (piece < pressure) {
      count += 1;
      isEnduring = true;
      debugPrint('TimePressure.hit: $count');
    } else {
      onHit.call();
      count = 0;
      isEnduring = false;
    }
    _watcher!.start();
  }
}
