import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:interview/data/user.dart';
import 'package:interview/data/mock_data.dart';
import 'package:interview/widgets/add_new_user_form.dart';
import 'package:interview/widgets/user_avatar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final searchController = TextEditingController();
  late List<User> allUsers = [];

  late List<User> displayedUsers = [];

  final foucsNode = FocusNode();
  @override
  void initState() {
    allUsers = User.fromJsonToList(allData());
    displayedUsers = allUsers;

    super.initState();

    searchController.addListener(_filterList);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      foucsNode.requestFocus();
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_filterList);
    searchController.dispose();
    foucsNode.dispose();
    super.dispose();
  }

  _filterList() {
    if (searchController.text.isEmpty) {
      setState(() {
        displayedUsers = User.fromJsonToList(allData());
      });
    } else {
      setState(() {
        displayedUsers = allUsers
            .where((element) => element.firstName
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) || element.lastName
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) || element.role
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _getUserAvatar(url) {
      return CircleAvatar(backgroundImage: NetworkImage(url));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                focusNode: foucsNode,
                controller: searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: displayedUsers.length,
              itemBuilder: (context, index) {
                final item = displayedUsers[index];
                return ListTile(
                  leading: UserAvatar(avatarUrl: item.avatar ?? ""),
                  title: Text('${item.firstName} ${item.lastName}'),
                  subtitle: Text(item.role),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          User? newUser = await showModalBottomSheet(context: context, builder: (_) => AddNewUserForm());
          // var newUser = User(
          //   id: "b32ec56c-21bb-4b7b-a3a0-635b8bca1f9d",
          //   avatar: null,
          //   firstName: "James",
          //   lastName: "May",
          //   email: "ssaull1c@tripod.com",
          //   role: "Developer",
          // );
          if (newUser == null) {
            return;
          }
          setState(() {
            allUsers.add(newUser);
            
            displayedUsers.add(newUser);
          });
        },
        tooltip: 'Add new',
        child: Icon(Icons.add),
      ),
    );
  }
}
