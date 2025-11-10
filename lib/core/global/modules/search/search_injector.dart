// import '../../../../data_layer/data_layer.dart';
// import '../../../../data_layer/repository/restaurant/establishment_repository_impl.dart';
// import '../../../../data_layer/repository/restaurant/i_establishment_repository.dart';
// import '../../../../domain_layer/domain_layer.dart';
import '../../../../layers/data_layer/data_layer.dart';
import '../../../../layers/data_layer/data_source/data_source.dart';
import '../../../../layers/domain_layer/controllers/controllers.dart';
import '../../../core.dart';

class SearchInjector extends ModuleBinds {
  SearchInjector({required super.getItInstance});

  @override
  void controllers() {
    registerLazySingleton(
      () => SearchInternetController(searchRepository: get<ISearchRepository>()),
    );
  }

  @override
  void datasources() {
    registerFactory(() => SearchDataSource(get<RestClient>()));
  }

  @override
  void repositories() {
    registerFactory<ISearchRepository>(
      () => SearchRepositoryImpl(get<SearchDataSource>()),
    );
  }
}
