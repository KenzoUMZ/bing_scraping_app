import '../../../../core/core.dart';
import '../../domain_layer.dart';

class SearchState extends BaseState {
  final BaseState searchState;
  final SearchResponseEntity? searchResponse;

  const SearchState({
    this.searchState = const BaseState(),
    this.searchResponse = const SearchResponseEntity(),
  });

  SearchState copyWith({
    BaseState? searchState,
    SearchResponseEntity? searchResponse,
  }) {
    return SearchState(
      searchState: searchState ?? this.searchState,
      searchResponse: searchResponse ?? this.searchResponse,
    );
  }

  @override
  List<Object?> get props => [searchState, searchResponse];
}
