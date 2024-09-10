part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class ChangeDisplayModeEvent extends AppEvent {
  const ChangeDisplayModeEvent(this.displayMode);

  final DisplayMode displayMode;

  @override
  List<Object> get props => [displayMode];
}

class ChangeTabEvent extends AppEvent {
  const ChangeTabEvent({required this.index});

  final int index;
  @override
  List<Object> get props => [index];
}
