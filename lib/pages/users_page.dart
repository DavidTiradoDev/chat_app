import 'package:chat_app/models/user.dart';
import 'package:chat_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  final List<User> users = [
    User(online: true, email: 'david@test.com', name: 'David', uid: '1'),
    User(online: false, email: 'esteban@test.com', name: 'Esteban', uid: '2'),
    User(online: true, email: 'juan@test.com', name: 'Juan', uid: '3'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi nombre'),
        elevation: 1,
        backgroundColor: AppColors.whiteColor,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.check_circle, color: AppColors.blueCheckColor),
          ),
        ],
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.exit_to_app)),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadUsers,
        onLoading: _onLoading,

        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue[400]!,
        ),
        child: _listViewUsers(),
      ),
    );
  }

  ListView _listViewUsers() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) => _userTile(users[index]),
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemCount: users.length,
    );
  }

  ListTile _userTile(User user) {
    return ListTile(
      title: Text(user.name),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: user.online ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(user.name.substring(0, 2)),
      ),
    );
  }

  void _loadUsers() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length + 1).toString());
    // if (mounted) setState(() {});
    // _refreshController.loadComplete();
  }
}
