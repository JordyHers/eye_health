
part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStarted extends TimerEvent {
  final int duration;

   TimerStarted({@required this.duration});

  @override
  String toString() => "TimerStarted { duration: $duration }";
}

class TimerPaused extends TimerEvent {}

class TimerResumed extends TimerEvent {}

class TimerReset extends TimerEvent {}

class TimerTicked extends TimerEvent {
  final int duration;

   TimerTicked({@required this.duration});

  @override
  List<Object> get props => [duration];

  @override
  String toString() => "TimerTicked { duration: $duration }";
}