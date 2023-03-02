import 'package:flutter/material.dart';
import 'package:todo/constants/variables.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  // List<String> usersInfo = [];

  List<String> customer = [];
  List<List> usersInfo = [];

  // void initstate() {
  //   super.initState();
  //   nameController.addListener(() {
  //     if (nameController.text.length == 0) {
  //       isNameEmpty = true;
  //     }
  //   });
  // }

  displayDialog(BuildContext context, String action, [int index = 0]) {
    bool isAgeEmpty = false;
    bool isNameEmpty = false;
    if (action == "UPDATE") {
      nameController.text = usersInfo[index][0];
      ageController.text = usersInfo[index][1];
    }
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Enter details"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    errorText: isNameEmpty ? "Required Field" : null,
                  ),
                ),
                TextField(
                  controller: ageController,
                  // onChanged: (text) {
                  //   isAgeEmpty = text.isEmpty;
                  // },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter your age",
                    errorText: isAgeEmpty ? "Required Field" : null,
                  ),
                  // onTap: () {
                  //   // if (val == '') {
                  //   //   isAgeEmpty = true;
                  //   //   print("age");
                  //   // }
                  //   setState(() {
                  //     // if (val == '') {
                  //     isAgeEmpty = true;
                  //     print(isAgeEmpty);
                  //     // }
                  //   });
                  // },
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // print(nameController.text);
                  // print(ageController.text);
                  setState(() {
                    print("add or update");
                    isNameEmpty = nameController.text.isEmpty ? true : false;
                    isAgeEmpty = ageController.text.isEmpty ? true : false;
                    if (!isNameEmpty && !isAgeEmpty && action == "ADD") {
                      customer.add(nameController.text);
                      customer.add(ageController.text);
                      usersInfo.add(customer);
                      Navigator.pop(context);
                      nameController.text = "";
                      ageController.text = "";
                    } else if (!isNameEmpty &&
                        !isAgeEmpty &&
                        action == "UPDATE") {
                      usersInfo[index][0] = nameController.text;
                      usersInfo[index][1] = ageController.text;
                      Navigator.pop(context);
                      nameController.text = "";
                      ageController.text = "";
                    }
                  });
                  customer = [];
                },
                child: Text("$action"),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("CANCEL")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // print("Build");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "USERS",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: themeColor,
      ),
      body: usersInfo.isNotEmpty
          ? ListView.builder(
              // itemCount: usersInfo.length,
              itemCount: usersInfo.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${index + 1}"),
                      Text("${usersInfo[index][0]}"),
                      Text("${usersInfo[index][1]}"),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            print("delete");
                            usersInfo.removeAt(index);
                          });
                        },
                        child: const Text("Delete"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            print("update");
                            displayDialog(context, "UPDATE", index);
                          });
                        },
                        child: const Text("Update"),
                      ),
                    ],
                  ),
                );
              })
          : const Center(
              child: Text(
              "No Users",
              style: TextStyle(fontSize: 20),
            )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => displayDialog(context, "ADD"),
        label: const Text("ADD USER"),
        backgroundColor: themeColor,
      ),
    );
  }
}
