import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_storage/shared_storage.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this.storage) : super(const AppState()) {
    on<ChangeTabEvent>(_onChangeTabEvent);
    on<ChangeDisplayModeEvent>(_onChangeDisplayModeEvent);
    final displayMode = storage.readString(key: 'displayMode');
    if (displayMode != '') {
      final mode = displayMode == DisplayMode.list.name
          ? DisplayMode.list
          : DisplayMode.grid;
      add(ChangeDisplayModeEvent(mode));
    }
  }

  final SharedStorage storage;

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
    storage.writeString(
      key: 'displayMode',
      value: event.displayMode.name,
    );
    emit(state.copyWith(displayMode: event.displayMode));
  }
}
