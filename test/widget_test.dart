// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:ceiba/data/repository/users_repository_impl.dart';
import 'package:ceiba/data/services/users_service.dart';
import 'package:ceiba/domain/bloc/post_bloc/post_bloc.dart';
import 'package:ceiba/domain/bloc/users_bloc/user_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

// Project imports:
@GenerateMocks([UserService])
void main() {
  group('Bloc Tests', () {
    blocTest<UserBloc, UserState>(
      'Should emit UsersCompleteState when GetUserEvent is added as event',
      build: () =>
          UserBloc(UsersRepositoryImpl(userService: UserService(Dio()))),
      act: (UserBloc bloc) => bloc.add(
        GetUserEvent(),
      ),
      expect: () => [isA<UsersCompleteState>()],
    );
    blocTest<PostBloc, PostState>(
      'Should emit CountriesComplete when GetCountriesEvent is added as event',
      build: () =>
          PostBloc(UsersRepositoryImpl(userService: UserService(Dio()))),
      act: (PostBloc bloc) => bloc.add(
        GetPostsEvent(1),
      ),
      expect: () => [isA<UsersPostCompleteState>()],
    );
  });
}
