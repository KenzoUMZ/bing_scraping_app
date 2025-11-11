import 'package:google_scraping_app/core/core.dart';
import 'package:google_scraping_app/layers/data_layer/repository/search/i_search_repository.dart';
import 'package:google_scraping_app/layers/domain_layer/domain_layer.dart';

class FakeSearchRepository implements ISearchRepository {
  FakeSearchRepository({this.shouldFail = false, this.response});

  final bool shouldFail;
  final SearchResponseEntity? response;

  @override
  Future<DualResponse<Failure, SearchResponseEntity>> search({
    required String searchTerm,
  }) async {
    if (shouldFail) {
      return ErrorResponse<Failure, SearchResponseEntity>(
        StatusFailure(500, msg: 'server_error'),
      );
    }
    return SuccessReponse<Failure, SearchResponseEntity>(
      response ?? const SearchResponseEntity(searchTerm: 'query', results: []),
    );
  }
}
