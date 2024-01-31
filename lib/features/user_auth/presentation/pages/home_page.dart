import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:world_time/global/common/toast.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HomePage',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        // leading: const BackButton(
        //   color: Colors.white,
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Welcome to home page",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                _createData(UserModel(
                  id: '',
                  username: "Thuy Lieu",
                  address: "India",
                  age: 12,
                ));
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Create Data",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<List<UserModel>>(
                stream: _readData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No Data Yet"),
                    );
                  }
                  final users = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                        children: users!.map((user) {
                      return ListTile(
                        leading: GestureDetector(
                          onTap: () {
                            _deleteData(user.id);
                          },
                          child: const Icon(Icons.delete),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            _updateData(UserModel(
                              id: user.id,
                              username: "Tuan Kiet",
                              address: "VietNam",
                              age: 21,
                            ));
                          },
                          child: const Icon(Icons.update),
                        ),
                        title: Text(user.username!),
                        subtitle: Text(user.address!),
                      );
                    }).toList()),
                  );
                }),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, "/login");
                showToast(message: 'Successfully Signed out');
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Sign out",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Stream<List<UserModel>> _readData() {
    final userCollection = FirebaseFirestore.instance.collection("users");
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map(
          (e) => UserModel.fromSnapshot(e),
        )
        .toList());
  }

  void _createData(UserModel userModel) {
    final userCollection = FirebaseFirestore.instance.collection("users");
    String id = userCollection.doc().id; //random ID

    final newUser = UserModel(
      id: id,
      username: userModel.username,
      address: userModel.address,
      age: userModel.age,
    ).toJson();
    userCollection.doc(id).set(newUser);
  }

  void _updateData(UserModel userModel) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    final newData = UserModel(
      id: userModel.id,
      username: userModel.username,
      address: userModel.address,
      age: userModel.age,
    ).toJson();

    userCollection.doc(userModel.id).update(newData);
  }

  void _deleteData(String id) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    userCollection.doc(id).delete();
  }
}

class UserModel {
  late final String id;
  late final String username;
  late final String address;
  late final int age;

  UserModel(
      {required this.id,
      required this.username,
      required this.address,
      required this.age});

  static UserModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      id: snapshot['id'],
      username: snapshot['username'],
      address: snapshot['address'],
      age: snapshot['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "address": address,
      "age": age,
    };
  }
}
