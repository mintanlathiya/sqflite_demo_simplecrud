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
  String gender = 'gender', male = 'male', feMale = 'feMale';
  double selectedage = 0;
  bool isUpdate = false;
  int selectId = 0;
  late Future<List<UserDetailModel>> futureUserData;
  @override
  void initState() {
    futureUserData = Localdatabase.selectData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.indigoAccent),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: fNameController,
                  decoration: const InputDecoration(
                      hintText: 'FulName', border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.indigoAccent),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: mNameController,
                  decoration: const InputDecoration(
                      hintText: 'MiddleName', border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.indigoAccent),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: lNameController,
                  decoration: const InputDecoration(
                      hintText: 'LastName', border: InputBorder.none),
                ),
              ),
            ),
            Row(
              children: [
                const Text('Gender :  '),
                const Text('Male: '),
                Radio(
                  value: male,
                  groupValue: gender,
                  onChanged: (value) {
                    gender = value!;
                    setState(() {});
                  },
                ),
                const Text('feMale: '),
                Radio(
                  value: feMale,
                  groupValue: gender,
                  onChanged: (value) {
                    gender = value!;
                    setState(() {});
                  },
                ),
              ],
            ),
            Slider(
              value: selectedage,
              onChanged: (value) {
                selectedage = value;
                setState(() {});
              },
              min: 0,
              max: 100,
              divisions: 100,
              label: '$selectedage',
            ),
            MaterialButton(
              onPressed: isUpdate
                  ? () async {
                      UserDetailModel obj = UserDetailModel(
                          fName: fNameController.text,
                          mName: mNameController.text,
                          lName: lNameController.text,
                          gender: gender,
                          age: selectedage,
                          id: selectId);
                      Localdatabase.updateData(obj);
                      futureUserData = Localdatabase.selectData();
                      fNameController.clear();
                      mNameController.clear();
                      lNameController.clear();
                      gender = 'gender';
                      selectedage = 0;
                      isUpdate = false;
                      setState(() {});
                    }
                  : () async {
                      await Localdatabase.insertdata(UserDetailModel(
                          fName: fNameController.text,
                          mName: mNameController.text,
                          lName: lNameController.text,
                          gender: gender,
                          age: selectedage));
                      futureUserData = Localdatabase.selectData();
                      fNameController.clear();
                      mNameController.clear();
                      lNameController.clear();
                      gender = 'gender';
                      selectedage = 0;
                      setState(() {});
                    },
              child: Text(isUpdate ? 'Update' : 'submit'),
            ),
            const SizedBox(height: 10),
            FutureBuilder(
              future: futureUserData,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            isUpdate = true;
                            fNameController.text = snapshot.data![index].fName;
                            mNameController.text = snapshot.data![index].mName;
                            lNameController.text = snapshot.data![index].lName;
                            gender = snapshot.data![index].gender;
                            selectedage = snapshot.data![index].age;
                            selectId = snapshot.data![index].id!;
                            setState(() {});
                          },
                          child: Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) async {
                              await Localdatabase.deleteData(
                                  snapshot.data![index].id!);
                              futureUserData = Localdatabase.selectData();
                              snapshot.data!.remove(snapshot.data![index]);
                              isUpdate = false;
                              setState(() {});
                            },
                            child: SizedBox(
                              height: 100,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('First: ${snapshot.data![index].fName}'),
                                  Text(
                                      'Middle: ${snapshot.data![index].mName}'),
                                  Text('Last: ${snapshot.data![index].lName}'),
                                  Text(
                                      'Gender: ${snapshot.data![index].gender}'),
                                  Text('Age: ${snapshot.data![index].age}'),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Text('There is no data');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
