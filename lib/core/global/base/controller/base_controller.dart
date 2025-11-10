import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global.dart';

abstract class BaseController<T extends BaseState> extends Cubit<T> {
  BaseController({required T initialState}) : super(initialState);

  StreamSubscription<T> listen({
    required Function(SuccessState success) onSuccess,
    required Function(FailureState failure, Object? result) onError,
    Function(BaseState state)? onState,
  }) {
    return stream.listen((state) {
      onState?.call(state);
      if (state is SuccessState) {
        onSuccess(state);
      } else if (state is FailureState) {
        onError(state, state.result);
      }
    });
  }
}

class BaseState extends Equatable {
  const BaseState();

  String get message => '';

  @override
  List<Object?> get props => [];
}
