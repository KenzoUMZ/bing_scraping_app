class SearchResponseEntity {
  final String? searchTerm;
  final List<ResultEntity>? results;

  const SearchResponseEntity({this.searchTerm, this.results});

  factory SearchResponseEntity.fromJson(Map<String, dynamic> json) {
    var resultsFromJson = json['results'] as List?;
    List<ResultEntity>? resultsList =
        resultsFromJson
            ?.map(
              (result) =>
                  ResultEntity(title: result['title'], url: result['url']),
            )
            .toList();

    return SearchResponseEntity(
      searchTerm: json['searchTerm'],
      results: resultsList,
    );
  }
}

class ResultEntity {
  final String? title;
  final String? url;

  ResultEntity({this.title, this.url});
}
