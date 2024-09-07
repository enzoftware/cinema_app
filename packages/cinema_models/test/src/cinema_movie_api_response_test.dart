import 'package:cinema_models/cinema_models.dart';
import 'package:test/test.dart';

void main() {
  group('CinemaMovieApiResponse', () {
    const json = {
      'page': 1,
      'results': [
        {
          'adult': false,
          'backdrop_path': '/lgkPzcOSnTvjeMnuFzozRO5HHw1.jpg',
          'genre_ids': [
            16,
            10751,
            35,
            28,
          ],
          'id': 519182,
          'original_language': 'en',
          'original_title': 'Despicable Me 4',
          'overview':
              'Gru and Lucy and their girls—Margo, Edith and Agnes—welcome',
          'popularity': 1346.005,
          'poster_path': '/wWba3TaojhK7NdycRhoQpsG0FaH.jpg',
          'release_date': '2024-06-20',
          'title': 'Despicable Me 4',
          'video': false,
          'vote_average': 7.222,
          'vote_count': 1439,
        },
        {
          'adult': false,
          'backdrop_path': '/9BQqngPfwpeAfK7c2H3cwIFWIVR.jpg',
          'genre_ids': [
            10749,
            18,
          ],
          'id': 1079091,
          'original_language': 'en',
          'original_title': 'It Ends with Us',
          'overview': "When a woman's first love suddenly reenters her life",
          'popularity': 769.307,
          'poster_path': '/4TzwDWpLmb9bWJjlN3iBUdvgarw.jpg',
          'release_date': '2024-08-07',
          'title': 'It Ends with Us',
          'video': false,
          'vote_average': 6.849,
          'vote_count': 249,
        },
        {
          'adult': false,
          'backdrop_path': '/6IrZ3C8qSZ8Tbb32s41ReJOXpI0.jpg',
          'genre_ids': [
            12,
            10751,
            14,
            35,
          ],
          'id': 826510,
          'original_language': 'en',
          'original_title': 'Harold and the Purple Crayon',
          'overview':
              'Inside of his book, adventurous Harold can make anything.',
          'popularity': 742.65,
          'poster_path': '/dEsuQOZwdaFAVL26RjgjwGl9j7m.jpg',
          'release_date': '2024-07-31',
          'title': 'Harold and the Purple Crayon',
          'video': false,
          'vote_average': 6.799,
          'vote_count': 92,
        },
      ],
      'total_pages': 164,
      'total_results': 3274,
    };

    final movieApiResponse = CinemaMovieApiResponse.fromJson(json);

    test('can be instantiated', () {
      expect(
        movieApiResponse,
        isNotNull,
      );
    });

    test('parsing fromJson', () async {
      final response = CinemaMovieApiResponse.fromJson(json);
      expect(response, isNotNull);
    });

    test('toJson', () {
      expect(movieApiResponse.toJson(), isNotNull);
    });

    test('supports equality', () {
      expect(CinemaMovieApiResponse.fromJson(json), movieApiResponse);
    });
  });
}
