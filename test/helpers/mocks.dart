import 'package:bloc_test/bloc_test.dart';
import 'package:cinema_app/app/app.dart';
import 'package:cinema_app/now_movies/now_movies.dart';
import 'package:cinema_app/popular_movies/popular_movies.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:shared_storage/shared_storage.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

class MockSharedStorage extends Mock implements SharedStorage {}

class MockPopularMoviesBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

class MockNowMoviesBloc extends MockBloc<NowMoviesEvent, NowMoviesState>
    implements NowMoviesBloc {}

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}
