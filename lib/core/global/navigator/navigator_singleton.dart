import 'package:flutter/material.dart';

class NavigatorSingleton {
  static final NavigatorSingleton _instance = NavigatorSingleton._internal();

  static NavigatorSingleton get I => _instance;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorSingleton._internal();

  factory NavigatorSingleton() {
    return _instance;
  }

  bool canPop() => navigatorKey.currentState?.canPop() ?? false;

  void pop<T extends Object?>({T? result}) {
    return navigatorKey.currentState?.pop<T>(result);
  }

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    return navigatorKey.currentState?.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
      routeName,
      ModalRoute.withName(routeName),
      arguments: arguments,
    );
  }

  Future<void> popUntil(String routeName) async {
    return navigatorKey.currentState?.popUntil((route) {
      return route.settings.name == routeName;
    });
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) async {
    return navigatorKey.currentState?.pushReplacementNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }
}
