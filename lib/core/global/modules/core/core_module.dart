import '../../../core.dart';
import 'core_injector.dart';

class CoreModule extends Module {
  @override
  ModuleBinds injector(GetIt getItInstance, Env env) {
    return CoreInjector(getItInstance: getItInstance, env: env);
  }
}
