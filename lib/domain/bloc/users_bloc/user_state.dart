part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UsersCompleteState extends UserState {
  final List<UserModel?> users;

  UsersCompleteState(this.users);
}
