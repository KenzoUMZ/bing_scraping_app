import 'package:flutter_test/flutter_test.dart';
import 'package:google_scraping_app/layers/domain_layer/entities/search/search_response_entity.dart';

void main() {
  group('SearchResponseEntity.fromJson', () {
    test('parses json into entity', () {
      final json = {
        'searchTerm': 'flutter',
        'results': [
          {'title': 'Flutter', 'url': 'https://flutter.dev'},
          {'title': 'Dart', 'url': 'https://dart.dev'},
        ],
      };

      final entity = SearchResponseEntity.fromJson(json);

      expect(entity.searchTerm, 'flutter');
      expect(entity.results, isNotNull);
      expect(entity.results!.length, 2);
      expect(entity.results![0].title, 'Flutter');
      expect(entity.results![1].url, 'https://dart.dev');
    });

    test('handles missing results', () {
      final json = {'searchTerm': 'empty'};
      final entity = SearchResponseEntity.fromJson(json);
      expect(entity.results, isNull);
    });
  });
}
