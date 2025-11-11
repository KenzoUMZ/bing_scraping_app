import 'package:flutter_test/flutter_test.dart';
import 'package:google_scraping_app/core/core.dart';
import 'package:google_scraping_app/layers/domain_layer/domain_layer.dart';

import '../test_helpers/fakes.dart';

void main() {
  group('SearchInternetController', () {
    test('emits success state and response on successful search', () async {
      final fakeRepo = FakeSearchRepository(
        response: const SearchResponseEntity(
          searchTerm: 'flutter',
          results: [],
        ),
      );

      final controller = SearchInternetController(searchRepository: fakeRepo);

  expect(controller.state.searchState, isA<BaseState>());
  expect(controller.state.searchResponse, isA<SearchResponseEntity>());

      await controller.search(searchTerm: 'flutter');

      expect(controller.state.searchState, const SearchSuccessState());
      expect(controller.state.searchResponse?.searchTerm, 'flutter');
    });

    test('emits FailureState on repository error', () async {
      final fakeRepo = FakeSearchRepository(shouldFail: true);
      final controller = SearchInternetController(searchRepository: fakeRepo);

      await controller.search(searchTerm: 'x');

      // searchState becomes FailureState
  expect(controller.state.searchState, isA<FailureState>());
    });
  });
}
