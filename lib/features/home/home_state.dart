import 'package:equatable/equatable.dart';
import 'package:login_demo/core/data/model/entities/account_entity.dart';

class HomeState extends Equatable {
  final AccountEntity? userInfo;

  const HomeState({this.userInfo});

  HomeState copyWith({AccountEntity? userInfo}) {
    return HomeState(userInfo: userInfo ?? this.userInfo);
  }

  @override
  List<Object?> get props => [userInfo];
}
