import 'env.dart';

class DevEnv extends Env {
  @override
  String get baseUrl => 'http://10.0.2.2:8080/api';
}
