import '../../../../core/core.dart';
import '../../../domain_layer/entities/search/search_response_entity.dart';
import '../../data_source/data_source.dart';
import 'i_search_repository.dart';

class SearchRepositoryImpl extends ISearchRepository {
  final SearchDataSource _dataSource;

  SearchRepositoryImpl(this._dataSource);
  @override
  Future<DualResponse<Failure, SearchResponseEntity>> search({
    required String searchTerm,
  }) {
    return ApiResponseHandler.validateResponse<SearchResponseEntity>(
      () async => _dataSource.fetchSearchResults(searchTerm),
      (data) => SearchResponseEntity.fromJson(data),
    );
  }
}
