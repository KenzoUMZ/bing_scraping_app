import '../../../../core/core.dart';
import '../../../data_layer/data_layer.dart';
import 'search_state.dart';

class SearchInternetController extends BaseController<SearchState> {
  final ISearchRepository _searchRepository;

  SearchInternetController({required ISearchRepository searchRepository})
    : _searchRepository = searchRepository,
      super(initialState: const SearchState());

  Future<void> search({required String searchTerm}) async {
    (await _searchRepository.search(searchTerm: searchTerm)).fold(
      onSuccess: (data) {
        emit(state.copyWith(searchResponse: data));
      },
      onError: (Failure error) {
        emit(state.copyWith(searchState: FailureState(error)));
      },
    );
  }
}
