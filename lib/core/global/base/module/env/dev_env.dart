import 'env.dart';

class DevEnv extends Env {
  @override
  String get baseUrl => 'http://YOUR_LOCAL_IP:8080';
}
