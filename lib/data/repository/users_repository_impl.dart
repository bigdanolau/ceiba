// Package imports:

// Project imports:
import 'package:ceiba/data/models/post_model.dart';
import 'package:ceiba/data/models/user_model.dart';
import 'package:ceiba/data/services/users_service.dart';
import 'package:ceiba/domain/repository/users_repository.dart';

class UsersRepositoryImpl extends UsersRepository {
  final UserService userService;

  UsersRepositoryImpl({
    required this.userService,
  });

  @override
  Future<List<PostModel?>> getUserPost(int userId) async {
    try {
      final List<PostModel> postList = await userService.getUserPost(userId);
      return postList;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<UserModel?>> getUsers() async {
    try {
      final List<UserModel> users = await userService.getUsers();
      return users;
    } catch (e) {
      return [];
    }
  }
}
