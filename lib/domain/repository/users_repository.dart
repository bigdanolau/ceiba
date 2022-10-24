// Project imports:
import 'package:ceiba/data/models/post_model.dart';
import 'package:ceiba/data/models/user_model.dart';

abstract class UsersRepository {
  Future<List<UserModel?>> getUsers();
  Future<List<PostModel?>> getUserPost(int userId);
}
