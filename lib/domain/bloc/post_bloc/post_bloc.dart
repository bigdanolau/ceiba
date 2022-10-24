import 'package:bloc/bloc.dart';
import 'package:ceiba/data/models/post_model.dart';
import 'package:ceiba/data/repository/users_repository_impl.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final UsersRepositoryImpl usersRepositoryImpl;
  PostBloc(this.usersRepositoryImpl) : super(PostInitial()) {
    on<PostEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetPostsEvent>((event, emit) async {
      final List<PostModel?> postList =
          await usersRepositoryImpl.getUserPost(event.userId);
      emit(
        UsersPostCompleteState(postList),
      );
    });
  }
}
