import 'package:cinema_app/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_repository/movie_repository.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  group('App', () {
    late MovieRepository movieRepository;

    setUp(() {
      movieRepository = MockMovieRepository();
    });

    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(
        CinemaMovieApp(
          movieRepository: movieRepository,
        ),
      );
      expect(find.byType(CinemaMovieHome), findsOneWidget);
    });
  });
}
