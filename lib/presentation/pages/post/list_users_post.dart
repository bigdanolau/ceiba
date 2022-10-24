// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ceiba/data/models/post_model.dart';

// Project imports:
import 'package:ceiba/domain/bloc/post_bloc/post_bloc.dart';
import 'package:ceiba/generated/l10n.dart';
import 'package:ceiba/presentation/utils/responsive.dart';

class ListUsersPostPage extends StatefulWidget {
  final int userId;
  final String userName;
  final String userPhoneNumber;
  final String userEmail;

  const ListUsersPostPage({
    Key? key,
    required this.userId,
    required this.userName,
    required this.userPhoneNumber,
    required this.userEmail,
  }) : super(key: key);

  @override
  State<ListUsersPostPage> createState() => ListUsersPostPageState();
}

class ListUsersPostPageState extends State<ListUsersPostPage>
    with WidgetsBindingObserver {
  TextEditingController editingController = TextEditingController();
  List<PostModel?> postList = [];
  List<PostModel?> postListFilter = [];
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
    BlocProvider.of<PostBloc>(context).add(
      GetPostsEvent(widget.userId),
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
          child: BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if (state is UsersPostCompleteState) {
                setState(() {
                  postList = state.userPost;
                  postListFilter = state.userPost;
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: sizeDevice.ip(1.5),
                          horizontal: sizeDevice.ip(2)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userName,
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
                                padding:
                                    EdgeInsets.only(left: sizeDevice.ip(0.8)),
                                child: Text(
                                  widget.userPhoneNumber,
                                  style:
                                      TextStyle(fontSize: sizeDevice.ip(1.8)),
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
                                padding:
                                    EdgeInsets.only(left: sizeDevice.ip(0.8)),
                                child: Text(
                                  widget.userEmail,
                                  style:
                                      TextStyle(fontSize: sizeDevice.ip(1.8)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
            ? postListFilter.isNotEmpty
                ? ListView.builder(
                    itemCount: postListFilter.length,
                    itemBuilder: (_, int index) {
                      return _buildCard(sizeDevice, postListFilter[index]!);
                    },
                  )
                : Text(S.current.emptyList)
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
            postListFilter = postList
                .where(
                  (e) =>
                      e?.title
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
      labelText: S.current.searchPost,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: mainColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: mainColor),
      ),
      border: const UnderlineInputBorder(),
    );
  }

  Card _buildCard(ResponsiveDimensions sizeDevice, PostModel post) {
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
                  post.title,
                  style: TextStyle(
                    fontSize: sizeDevice.ip(2),
                    color: mainColor,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: sizeDevice.ip(1.5),
                ),
                Text(
                  post.body.substring(50),
                  style: TextStyle(fontSize: sizeDevice.ip(1.8)),
                ),
                SizedBox(
                  height: sizeDevice.ip(1.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: sizeDevice.ip(0.8)),
                      child: InkWell(
                        onTap: () {
                          sendUSerMessage(S.current.workingOnIt);
                        },
                        child: Text(
                          S.current.readMore.toUpperCase(),
                          style: TextStyle(
                            fontSize: sizeDevice.ip(1.7),
                            color: mainColor,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.justify,
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
