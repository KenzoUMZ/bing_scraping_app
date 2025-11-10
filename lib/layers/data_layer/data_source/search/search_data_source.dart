import 'package:dio/dio.dart';

import '../../../../core/core.dart';

class SearchDataSource {
  final RestClient _restClient;

  SearchDataSource(this._restClient);

  Future<Response> fetchSearchResults(String query) async {
    final response = await _restClient.dio.post(
      '/scrape',
      data: {'query': query},
    );

    return response;
  }
}
