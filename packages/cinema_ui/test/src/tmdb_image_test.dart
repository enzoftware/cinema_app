import 'package:cinema_ui/cinema_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  group('TMDBImage', () {
    testWidgets('renders image successfully', (WidgetTester tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: TMDBImage(
                path: '/valid_path.jpg',
                width: 150,
                height: 225,
              ),
            ),
          ),
        );

        expect(find.byType(Image), findsOneWidget);
      });
    });

    testWidgets('displays loading indicator while image is loading',
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: TMDBImage(
                path: '/loading_path.jpg',
                width: 150,
                height: 225,
              ),
            ),
          ),
        );

        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    testWidgets('applies correct width and height',
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: TMDBImage(
                path: '/valid_path.jpg',
                width: 150,
                height: 225,
              ),
            ),
          ),
        );

        final image = tester.widget<Image>(find.byType(Image));
        expect(image.width, 150);
        expect(image.height, 225);
      });
    });
  });
}
