import 'package:login_demo/core/data/model/entities/account_entity.dart';
import 'package:login_demo/core/data/model/enums/login_status.dart';

class LoginResult {
  final LoginStatus status;

  final AccountEntity? account;

  LoginResult(this.status, {this.account});
}
