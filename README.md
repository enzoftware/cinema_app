# Cinema App

[Give try via diawi](https://i.diawi.com/3L1jAk)

Cinema App is a mobile application built for Kueski, using Flutter to showcase popular and now playing movies by fetching data from TheMovieDB API. The app also allows users to save favorite movies, and switch between different display modes.

## Features

- **Popular Movies**: List the most popular movies fetched from TheMovieDB API.
- **Now Playing Movies**: List the movies currently playing in theaters.
- **List/Grid Toggle**: Toggle between a list or grid view to display the movies.
- **Pagination**: Automatically load more movies as the user scrolls down.
- **Favorites**: Save favorite movies locally and view them when reopening the app.
- **Error Handling**: Display different error messages for various network issues, like connection failures or API errors.

### [Bonus Features]

- **Movie Sorting**: Sort movies by date or name (not mandatory but added for enhancement).

## Architecture and Design

The app is built with a **modular architecture** and follows best practices such as clean code and separation of concerns. The following key design principles have been implemented:

- **State Management**: `flutter_bloc` is used for state management, providing clear separation between UI and business logic.
- **Modularity**: The app is divided into separate packages:
  - `cinema_api_client`: Handles the network requests to TheMovieDB API using `dio`.
  - `cinema_models`: Defines data models for movies, API responses, and errors.
  - `movie_repository`: Acts as a repository layer to abstract the API logic and provide data to the app.
  - `cinema_ui`: Contains reusable UI components like movie cards and grids.
- **Error Handling**: Comprehensive error handling to manage and display errors related to API requests or connection issues.
- **Dependency Injection**: Dependencies are injected using Flutter's `BuildContext` to keep the components loosely coupled.

## Getting Started

### Prerequisites

- Ensure you have [Flutter SDK](https://flutter.dev/docs/get-started/install) installed.
- You need a valid **API Key** from [TheMovieDB](https://www.themoviedb.org/settings/api).

### Installing

1. Clone the repository:

   ```bash
   git clone https://github.com/enzoftware/cinema_app.git
   cd cinema_app
   ```

2. Install the dependencies:

   ```bash
   flutter pub get
   ```

3. Add your API Key:
  Create `api_keys.json`, and follow the `api_keys_example.json` to add your TheMovieDB API key:

     ```json
    {
      "TMDB_API_KEY":"your_api_key"
    }
     ```

4. Run the app on an emulator or physical device:

   ```bash
   flutter run --target lib/main_development.dart --dart-define-from-file api_keys.json
   ```

### Running Tests

This project includes unit and widget tests for the repository and UI components. To run the tests, use:

```bash
flutter test
```

### Project Structure

``` bash
/lib
  /app          # App-level code and main entry point
  /popular_movies  # Popular movies feature
  /now_playing_movies  # Now playing movies feature
/packages
  /cinema_api_client   # API client to handle TMDB API requests
  /cinema_models   # Models for movies and responses
  /movie_repository   # Repository layer abstracting API logic
  /cinema_ui    # Reusable UI components like movie cards
```

## Libraries & Tools Used

- **[Flutter](https://flutter.dev/)**: Cross-platform framework for building the app.
- **[bloc](https://pub.dev/packages/bloc)**: Business logic component for state management.
- **[flutter_bloc](https://pub.dev/packages/flutter_bloc)**: Flutter integration for the `bloc` pattern.
- **[dio](https://pub.dev/packages/dio)**: HTTP client used to handle API requests.
- **[equatable](https://pub.dev/packages/equatable)**: For easy value comparisons in `bloc` states.
- **[intl](https://pub.dev/packages/intl)**: Internationalization and date formatting.
- **[mocktail](https://pub.dev/packages/mocktail)**: For testing mock objects.
- **[very_good_analysis](https://pub.dev/packages/very_good_analysis)**: Linting and analysis.

## Known Restrictions

- The app requires an active internet connection to fetch movie data.
- Error handling for API limits is basic and can be improved to notify the user properly.s

## License

This project is licensed under the MIT License.

---
