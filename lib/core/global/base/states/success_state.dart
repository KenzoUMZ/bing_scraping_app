import '../../global.dart';

class SuccessState extends BaseState {
  @override
  final String message;
  final Object? result;

  const SuccessState({this.message = '', this.result});

  @override
  List<Object?> get props => [message];
}
