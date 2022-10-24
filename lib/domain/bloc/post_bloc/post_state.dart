part of 'post_bloc.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class UsersPostCompleteState extends PostState {
  final List<PostModel?> userPost;

  UsersPostCompleteState(this.userPost);
}
