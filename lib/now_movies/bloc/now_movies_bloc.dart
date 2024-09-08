import 'package:bloc/bloc.dart';
part 'now_movies_event.dart';
part 'now_movies_state.dart';

class NowMoviesBloc extends Bloc<NowMoviesEvent, NowMoviesState> {
  NowMoviesBloc() : super(NowMoviesInitial()) {
    on<NowMoviesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
