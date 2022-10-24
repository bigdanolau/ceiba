// Package imports:
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ceiba/data/models/post_model.dart';

// Project imports:
import 'package:ceiba/data/models/user_model.dart';

class UserService {
  final Dio client;
  final storage = const FlutterSecureStorage();

  UserService(this.client);

  Future<List<UserModel>> getUsers() async {
    try {
      final String? localUsers = await storage.read(key: 'users');
      if (localUsers != null) {
        final List<UserModel> localUsersList =
            jsonDecode(localUsers).map<UserModel>(
          (dynamic json) {
            return UserModel.fromJson(json);
          },
        ).toList();
        if (localUsersList.isNotEmpty) {
          return localUsersList;
        }
      }

      final response = await client.get<dynamic>(
        '${dotenv.get('API_URL')}users/',
      );
      if (response.statusCode == 200) {
        final parsed = response.data;
        final List<UserModel> userList = parsed.map<UserModel>(
          (dynamic json) {
            return UserModel.fromJson(json);
          },
        ).toList();
        await storage.write(key: 'users', value: jsonEncode(userList));
        return userList;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<PostModel>> getUserPost(int userId) async {
    try {
      final response = await client.get<dynamic>(
        '${dotenv.get('API_URL')}posts?userId=$userId',
      );
      if (response.statusCode == 200) {
        final parsed = response.data;
        final List<PostModel> postList = parsed.map<PostModel>(
          (dynamic json) {
            return PostModel.fromJson(json);
          },
        ).toList();
        return postList;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      return [];
    }
  }
}
