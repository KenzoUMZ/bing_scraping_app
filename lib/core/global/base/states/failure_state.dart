import 'package:http_interceptor/http_interceptor.dart';

import '../../../core.dart';

class FailureState extends BaseState {
  final Object? result;

  final Failure failure;

  const FailureState(this.failure, {this.result});

  @override
  List<Object?> get props => [result, failure];

  StatusFailure get statusFailure {
    if (failure is StatusFailure) {
      return failure as StatusFailure;
    }

    final result = switch (failure.runtimeType) {
      // UnknownFailure _ => -999,
      _ => -998,
    };
    return StatusFailure(result, msg: failure.message);
  }
}

abstract class Failure {
  String get message;
}

class StatusFailure implements Failure {
  final int status;
  final String? msg;
  final ClientException? fullException;

  StatusFailure(this.status, {this.msg, this.fullException});

  @override
  String get message => msg ?? 'an_unknown_error_occurred_please_try_again';
}

class AuthFailure implements Failure {
  final int status;
  final String? msg;

  AuthFailure(this.status, {this.msg});

  @override
  String get message => msg ?? 'unauthorized';
}

class NullFailure implements Failure {
  NullFailure();

  @override
  String get message => 'unknown_error';
}

class UnknownFailure implements Failure {
  const UnknownFailure();

  @override
  String get message => 'unknown_error';
}

class ServerError implements Failure {
  final int status;
  ServerError(this.status);

  @override
  String get message => 'server_error';
}
