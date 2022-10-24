// Flutter imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:ceiba/data/models/user_model.dart';
import 'package:ceiba/domain/bloc/users_bloc/user_bloc.dart';
import 'package:ceiba/generated/l10n.dart';
import 'package:ceiba/main.dart';
import 'package:ceiba/presentation/utils/responsive.dart';

class ListUsersPage extends StatefulWidget {
  const ListUsersPage({Key? key}) : super(key: key);

  @override
  State<ListUsersPage> createState() => ListUsersPageState();
}

class ListUsersPageState extends State<ListUsersPage>
    with WidgetsBindingObserver {
  TextEditingController editingController = TextEditingController();
  List<UserModel?> userList = [];
  List<UserModel?> userListFilter = [];
  bool inizialiteData = false;
  final Color mainColor = const Color(0xff2c5736);
  @override
  void initState() {
    super.initState();
    _initializeData(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _initializeData(context);
    }
  }

  void _initializeData(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(
      GetUserEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveDimensions sizeDevice = ResponsiveDimensions.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          S.current.title,
          style: TextStyle(
            fontSize: sizeDevice.ip(2.5),
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: sizeDevice.widthDevice,
          height: sizeDevice.heightDevice,
          child: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UsersCompleteState) {
                setState(() {
                  userList = state.users;
                  userListFilter = state.users;
                  inizialiteData = true;
                });
              }
            },
            builder: (context, state) {
              return Container(
                width: sizeDevice.widthDevice,
                height: sizeDevice.heightDevice,
                margin: EdgeInsets.symmetric(
                  horizontal: sizeDevice.ip(2),
                  vertical: sizeDevice.ip(1),
                ),
                child: Column(
                  children: [
                    _buildSeachBar(sizeDevice),
                    _buildMainView(sizeDevice),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Expanded _buildMainView(ResponsiveDimensions sizeDevice) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: sizeDevice.ip(2),
        ),
        child: inizialiteData
            ? ListView.builder(
                itemCount: userListFilter.length,
                itemBuilder: (_, int index) {
                  return _buildCard(sizeDevice, userListFilter[index]!);
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Container _buildSeachBar(ResponsiveDimensions sizeDevice) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizeDevice.ip(1)),
      child: TextField(
        onChanged: (value) {
          setState(() {
            userListFilter = userList
                .where(
                  (e) =>
                      e?.name
                          .toLowerCase()
                          .contains(editingController.text.toLowerCase()) ==
                      true,
                )
                .toList();
          });
        },
        controller: editingController,
        decoration: _buildStylesForSearchBar(),
      ),
    );
  }

  InputDecoration _buildStylesForSearchBar() {
    return InputDecoration(
      labelStyle: TextStyle(color: mainColor),
      labelText: S.current.search,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: mainColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: mainColor),
      ),
      border: const UnderlineInputBorder(),
    );
  }

  Card _buildCard(ResponsiveDimensions sizeDevice, UserModel user) {
    return Card(
      margin: EdgeInsets.all(sizeDevice.ip(1)),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(
              left: sizeDevice.ip(2),
              right: sizeDevice.ip(2),
              top: sizeDevice.ip(1),
              bottom: sizeDevice.ip(2),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: sizeDevice.ip(2.5),
                    color: mainColor,
                  ),
                  textAlign: TextAlign.start,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: mainColor,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: sizeDevice.ip(0.8)),
                      child: Text(
                        user.phone,
                        style: TextStyle(fontSize: sizeDevice.ip(1.8)),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: mainColor,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: sizeDevice.ip(0.8)),
                      child: Text(
                        user.email,
                        style: TextStyle(fontSize: sizeDevice.ip(1.8)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: sizeDevice.ip(1.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Connectivity()
                            .checkConnectivity()
                            .then((connectivityResult) {
                          if (connectivityResult != ConnectivityResult.none) {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.listUsersPost,
                              arguments: ScreenArguments(user.id),
                            );
                          } else {
                            sendUSerMessage(S.current.netWorkError);
                          }
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: sizeDevice.ip(0.8)),
                        child: Text(
                          S.current.goToPost.toUpperCase(),
                          style: TextStyle(
                            fontSize: sizeDevice.ip(1.7),
                            color: mainColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> sendUSerMessage(
      String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
