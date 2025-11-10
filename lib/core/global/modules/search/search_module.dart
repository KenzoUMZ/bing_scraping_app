import '../../../core.dart';
import 'search_injector.dart';

class SearchModule extends Module {
  @override
  ModuleBinds injector(GetIt getItInstance, Env env) {
    return SearchInjector(getItInstance: getItInstance);
  }
}
