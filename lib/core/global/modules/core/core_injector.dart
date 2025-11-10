import '../../../core.dart';

class CoreInjector extends ModuleBinds {
  CoreInjector({required super.getItInstance, required this.env});

  final Env env;

  @override
  void controllers() {}

  @override
  void datasources() {
    // registerSingleton<ISharedPreferences>(SharedPreferencesImpl());
    // registerSingleton<PBBaseStoreClient>(PbStoreClientImpl(env: env));
    // registerSingleton<PbStoreFilesClient>(PbStoreFilesClient(env: env));
    // registerSingleton<PBRestClient>(PBRestClient(env: env));
    registerSingleton<RestClient>(RestClient(env: env));
  }

  @override
  void repositories() {}
}
