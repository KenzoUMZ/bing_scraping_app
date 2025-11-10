import 'package:flutter/material.dart';

import '../../../core.dart';

class ModularApp extends StatefulWidget {
  const ModularApp({
    super.key,
    required this.modules,
    required this.child,
    required this.devEnv,
    this.devEnvSuffix = 'dev',
  });

  final List<Module> modules;
  final Widget child;
  final Env devEnv;
  final String devEnvSuffix;

  @override
  State<ModularApp> createState() => _ModularAppState();
}

class _ModularAppState extends State<ModularApp> {
  final modulesStarted = ValueNotifier<bool>(false);

  @override
  void initState() {
    initEnv().then((env) => initModules(env));
    super.initState();
  }

  void initModules(Env env) {
    for (final module in widget.modules) {
      module.injector(GetIt.instance, env).register();
    }
    modulesStarted.value = true;
  }

  Future<Env> initEnv() async {
    return widget.devEnv;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: modulesStarted,
      builder: (context, started, _) {
        if (started) return widget.child;

        return const SizedBox();
      },
    );
  }
}

abstract class Module {
  ModuleBinds injector(GetIt getItInstance, Env env);
}

abstract class ModuleBinds {
  ModuleBinds({required this.getItInstance});

  final GetIt getItInstance;

  void datasources();

  void repositories();

  void controllers();

  void register() {
    datasources();
    repositories();
    controllers();
  }

  void registerFactory<T extends Object>(T Function() factoryFunc) {
    getItInstance.registerFactory<T>(factoryFunc);
  }

  void registerSingleton<T extends Object>(T instance) {
    getItInstance.registerSingleton<T>(instance);
  }

  void registerLazySingleton<T extends Object>(T Function() factoryFunc) {
    getItInstance.registerLazySingleton<T>(factoryFunc);
  }

  T get<T extends Object>() {
    return getItInstance.get<T>();
  }
}
