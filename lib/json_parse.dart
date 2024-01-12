import 'package:flutter/material.dart';
import 'package:jsondata_ex01/repository.dart';
import 'package:jsondata_ex01/user.dart';

class JsonParse extends StatefulWidget {
  const JsonParse({super.key});

  @override
  State<JsonParse> createState() => _JsonParseState();
}

class _JsonParseState extends State<JsonParse> {
  List<User> _users = <User>[];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    Repository.getInfo().then((value) {
      //initState,setState에 async를 사용하지 못하므로
      setState(() {
        // then 메소드를 사용해서 처리한다.
        _users = value;
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isLoaded ? 'User' : 'Loading...')),
      body: ListView.builder(
          itemCount: _users.length,
          itemBuilder: (context, i) {
            final user = _users[i];
            return ListTile(
                leading: const Icon(Icons.account_circle_rounded,
                    color: Colors.blue),
                trailing: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text(user.name),
                              content: Text(
                                  'email: ${user.email}\ncity: ${user.address.city}\nphone: ${user.phone}'),
                              actions: [
                                TextButton(
                                  child: const Text('닫기'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    icon: const Icon(Icons.phone_android_outlined,
                        color: Colors.red)),
                title: Text(user.name),
                subtitle: Text(user.email));
          }),
    );
  }
}
