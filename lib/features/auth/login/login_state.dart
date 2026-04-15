import 'package:equatable/equatable.dart';
import 'package:login_demo/core/data/model/enums/load_status.dart';

class LoginState extends Equatable {
  final LoadStatus loadLoginStatus;
  final bool isSubmit;

  const LoginState({
    this.loadLoginStatus = LoadStatus.initial,
    this.isSubmit = false,
  });

  LoginState copyWith({LoadStatus? loadLoginStatus, bool? isSubmit}) {
    return LoginState(
      loadLoginStatus: loadLoginStatus ?? this.loadLoginStatus,
      isSubmit: isSubmit ?? this.isSubmit,
    );
  }

  @override
  List<Object?> get props => [loadLoginStatus, isSubmit];
}
