import 'dart:io';

import 'package:cinema_ui/cinema_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  group('error', () {
    late HttpClient httpClient;

    setUpAll(() {
      httpClient = MockHttpClient();
    });

    tearDownAll(() {
      // Reset HttpOverrides after each test
      HttpOverrides.global = null;
    });

    testWidgets('displays error message when image fails to load',
        (WidgetTester tester) async {
      when(
        () => httpClient.getUrl(
          Uri.parse('https://image.tmdb.org/t/p/w500/invalid_path.jpg'),
        ),
      ).thenThrow(Exception());

      await HttpOverrides.runZoned(
        () async {
          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                body: TMDBImage(
                  path: '/invalid_path.jpg',
                  width: 150,
                  height: 225,
                ),
              ),
            ),
          );

          await tester.pump(); // Simulate the loading/error state

          expect(find.text('Error'), findsOneWidget);
          expect(find.byIcon(Icons.error_outline), findsOneWidget);
        },
        createHttpClient: (_) => httpClient,
      );
    });
  });

  group('loading', () {
    setUpAll(() {
      HttpOverrides.global = null;
    });
    tearDownAll(() {
      // Reset HttpOverrides after each test to avoid interference
      HttpOverrides.global = null;
    });
    testWidgets('displays CircularProgressIndicator while loading',
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: TMDBImage(
                path: '/imagePath.png',
                width: 150,
                height: 225,
              ),
            ),
          ),
        );

        await tester.pump(); // simulate the image loading
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });
  });
}
