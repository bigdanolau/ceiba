// Flutter imports:
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:ceiba/data/repository/users_repository_impl.dart';
import 'package:ceiba/data/services/users_service.dart';
import 'package:ceiba/domain/bloc/post_bloc/post_bloc.dart';
import 'package:ceiba/domain/bloc/users_bloc/user_bloc.dart';
import 'package:ceiba/presentation/pages/post/list_users_post.dart';
import 'package:ceiba/presentation/pages/users/list_users.dart';
import 'generated/l10n.dart';

void main() async {
  await dotenv.load();
  await _forceOrientation();
  await _initializeGetIt();
  _initializeSplash();
  runApp(
    const RootPage(),
  );
}

void _initializeSplash() {
  WidgetsFlutterBinding.ensureInitialized();
}

Future<void> _forceOrientation() =>
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

Future<void> _initializeGetIt() async {
  await _registerAppDependencies();
}

Future<void> _registerAppDependencies() async {
  GetIt.I
    ..registerLazySingleton<Dio>(
      Dio.new,
    )
    ..registerLazySingleton<UserService>(() => UserService(GetIt.I<Dio>()))
    ..registerLazySingleton<UsersRepositoryImpl>(
      () => UsersRepositoryImpl(userService: GetIt.I<UserService>()),
    );
}

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      routes: _getAppRoutesInitialization(),
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == AppRoutes.listUsersPost) {
          // Cast the arguments to the correct
          // type: ScreenArguments.
          final args = settings.arguments as ScreenArguments;

          // Then, extract the required data from
          // the arguments and pass the data to the
          // correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return BlocProvider<PostBloc>(
                create: (_) => PostBloc(GetIt.I<UsersRepositoryImpl>()),
                child: ListUsersPostPage(
                  userId: args.userId,
                ),
              );
            },
          );
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
      initialRoute: AppRoutes.listUsers,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }

  Map<String, Widget Function(dynamic context)> _getAppRoutesInitialization() =>
      {
        AppRoutes.listUsers: (_) => _createListUserPageWithBloc(),
      };
}

BlocProvider _createListUserPageWithBloc() {
  return BlocProvider<UserBloc>(
    create: (_) => UserBloc(GetIt.I<UsersRepositoryImpl>()),
    child: const ListUsersPage(),
  );
}

class AppRoutes {
  static const listUsers = '/';
  static const listUsersPost = '/post';
}

class ScreenArguments {
  final int userId;

  ScreenArguments(this.userId);
}
