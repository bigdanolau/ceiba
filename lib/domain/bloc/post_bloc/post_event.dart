part of 'post_bloc.dart';

abstract class PostEvent {}

class GetPostsEvent extends PostEvent {
  final int userId;
  GetPostsEvent(this.userId);
}
