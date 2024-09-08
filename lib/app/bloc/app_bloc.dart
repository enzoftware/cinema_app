import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<ChangeTabEvent>(_onChangeTabEvent);
    on<ChangeDisplayModeEvent>(_onChangeDisplayModeEvent);
  }

  FutureOr<void> _onChangeTabEvent(
    ChangeTabEvent event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(selectedIndex: event.index));
  }

  FutureOr<void> _onChangeDisplayModeEvent(
    ChangeDisplayModeEvent event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(displayMode: event.displayMode));
  }
}
