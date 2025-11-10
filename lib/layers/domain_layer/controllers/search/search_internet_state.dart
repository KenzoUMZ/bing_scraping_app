import '../../../../core/core.dart';
import '../../domain_layer.dart';

class SearchInternetState extends BaseState {
  final BaseState searchState;
  final SearchResponseEntity? searchResponse;

  const SearchInternetState({
    this.searchState = const BaseState(),
    this.searchResponse = const SearchResponseEntity(),
  });

  SearchInternetState copyWith({
    BaseState? searchState,
    SearchResponseEntity? searchResponse,
  }) {
    return SearchInternetState(
      searchState: searchState ?? this.searchState,
      searchResponse: searchResponse ?? this.searchResponse,
    );
  }

  @override
  List<Object?> get props => [searchState, searchResponse];
}

class SearchSuccessState extends SuccessState {
  const SearchSuccessState();

  @override
  List<Object?> get props => [];
}
