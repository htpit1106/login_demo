import 'package:equatable/equatable.dart';
import 'package:login_demo/core/data/model/enums/load_status.dart';

class LoginState extends Equatable {
  final LoadStatus loadLoginStatus;
  final bool isSubmit;
  final bool isLoginCountLimit;

  const LoginState({
    this.loadLoginStatus = LoadStatus.initial,
    this.isSubmit = false,
    this.isLoginCountLimit = false,
  });

  LoginState copyWith({
    LoadStatus? loadLoginStatus,
    bool? isSubmit,
    bool? isLoginCountLimit,
  }) {
    return LoginState(
      loadLoginStatus: loadLoginStatus ?? this.loadLoginStatus,
      isSubmit: isSubmit ?? this.isSubmit,
      isLoginCountLimit: isLoginCountLimit ?? this.isLoginCountLimit,
    );
  }

  @override
  List<Object?> get props => [loadLoginStatus, isSubmit, isLoginCountLimit];
}
