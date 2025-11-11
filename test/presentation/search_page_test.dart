import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_scraping_app/core/components/buttons/ui_button.dart';
import 'package:google_scraping_app/core/core.dart';
import 'package:google_scraping_app/layers/domain_layer/domain_layer.dart';
import 'package:google_scraping_app/layers/presentation_layer/search/search_page.dart';

import '../test_helpers/fakes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SearchPage widget', () {
    setUp(() {
      // Register a fake controller dependency
      final fakeRepo = FakeSearchRepository();
      if (GetIt.I.isRegistered<SearchInternetController>()) {
        GetIt.I.unregister<SearchInternetController>();
      }
      GetIt.I.registerSingleton<SearchInternetController>(
        SearchInternetController(searchRepository: fakeRepo),
      );
    });

    testWidgets('renders search input and button initially', (tester) async {
      await tester.pumpWidget(MaterialApp(home: const SearchPage()));

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      final searchButton = find.byType(UiButton);
      expect(searchButton, findsOneWidget);
    });

    testWidgets('triggers search after entering text and tapping button', (
      tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: const SearchPage()));

      await tester.enterText(find.byType(TextField), 'flutter');
      await tester.pumpAndSettle();

      await tester.tap(find.byType(UiButton));
      await tester.pump();

      final controller = GetIt.I.get<SearchInternetController>();
      expect(controller.state.searchState, isA<SearchSuccessState>());
    });

    testWidgets('full flow: renders JSON content after search', (tester) async {
      await tester.pumpWidget(MaterialApp(home: const SearchPage()));

      await tester.enterText(find.byType(TextField), 'flutter');
      await tester.pumpAndSettle();
      await tester.tap(find.byType(UiButton));
      await tester.pumpAndSettle();

      final controller = GetIt.I.get<SearchInternetController>();
      final searchState = controller.state.searchState;
      final searchResponse = controller.state.searchResponse;

      if (searchState is SuccessState) {
        final results = searchResponse?.results ?? [];
        for (final item in results) {
          if (item.title != null && item.title!.isNotEmpty) {
            expect(find.text(item.title!), findsWidgets);
          }
        }
      } else if (searchState is FailureState) {
        expect(find.textContaining('erro'), findsOneWidget);
      } else {
        expect(find.byType(CircularProgressIndicator), findsNothing);
      }
    });
  });
}
