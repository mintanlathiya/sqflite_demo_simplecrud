import 'package:flutter/material.dart';
import 'package:sqflite_demo_simplecrud/local_database.dart';
import 'package:sqflite_demo_simplecrud/user_modal.dart';

class HomeScreenSqfliteDemo extends StatefulWidget {
  const HomeScreenSqfliteDemo({super.key});

  @override
  State<HomeScreenSqfliteDemo> createState() => _HomeScreenSqfliteDemoState();
}

class _HomeScreenSqfliteDemoState extends State<HomeScreenSqfliteDemo> {
  TextEditingController fNameController = TextEditingController();
  TextEditingController mNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: fNameController,
          ),
          TextField(
            controller: mNameController,
          ),
          TextField(
            controller: lNameController,
          ),
          MaterialButton(
            onPressed: () async {
              await Localdatabase.insertdata(UserDetailModel(
                  fName: fNameController.text,
                  mName: mNameController.text,
                  lName: lNameController.text));
            },
            child: const Text('submmit'),
          )
        ],
      ),
    );
  }
}
