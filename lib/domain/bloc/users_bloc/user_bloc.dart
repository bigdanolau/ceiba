import 'package:bloc/bloc.dart';
import 'package:ceiba/data/models/user_model.dart';
import 'package:ceiba/data/repository/users_repository_impl.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersRepositoryImpl usersRepositoryImpl;
  UserBloc(this.usersRepositoryImpl) : super(UserInitial()) {
    on<UserEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetUserEvent>((event, emit) async {
      final List<UserModel?> userList = await usersRepositoryImpl.getUsers();
      emit(
        UsersCompleteState(userList),
      );
    });
  }
}
