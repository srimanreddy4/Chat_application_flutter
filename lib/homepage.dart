import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_appdev/chatroom.dart' ;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic>? userMap; // Add '?' to indicate it can be null
  bool isLoading = false;

  final TextEditingController _searchController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2" ;
    } else {
      return "$user2$user1" ;
    }

  }

  
  void _showProfileMenu(BuildContext context) {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Change Username"),
                onTap: () {
                  Navigator.of(context).pop(); // Close the menu
                  // Implement the logic to change the username here
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text("Tell About Yourself"),
                onTap: () {
                  Navigator.of(context).pop(); // Close the menu
                  // Implement the logic to tell about yourself here
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Log Out"),
                onTap: () async {
                  await _auth.signOut();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void onsearch() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    setState(() {
      isLoading = true;
    });

     await _firestore
        .collection('users')
        .where("name", isEqualTo: _searchController.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.fromLTRB(10.0,0,0,0),
          child: Text('Chat App'),
        ),
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading : false,
        actions: [
          IconButton(
             icon: const Icon(Icons.account_circle),
            onPressed: () => _showProfileMenu(context),
            // icon: const Icon(Icons.logout),
            // onPressed: () async {
            //   await _auth.signOut();
            //   Navigator.of(context).popUntil((route) => route.isFirst);
            // },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: Container(height: size.height / 20, width: size.height / 20, child: const CircularProgressIndicator()))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search users by username',
                      fillColor: Colors.cyan,
                      hoverColor: Colors.indigo,
                      focusColor: Colors.teal,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          onsearch(); // Call the search function here
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                if (userMap != null)
                  ListTile(
                    onTap: () {
                       if (_auth.currentUser != null) {
    String roomId = chatRoomId(
      _auth.currentUser!.displayName!,
      userMap!['name'],
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChatRoom(
          chatRoomId: roomId,
          userMap: userMap!,
                          )
                        )
                      );




                    };
                    },
                    


                    leading: const Icon(Icons.account_box, color: Colors.black),
                    title: Text(userMap!['name'], style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500)),
                    subtitle: Text(userMap!['email']),
                    trailing: const Icon(Icons.chat, color: Colors.black),
                  )
                else
                  const Center(
                    child: Text('No user found with the given name.'),
                  ),
              const SizedBox(height: 120,) ,
              // const Text('My recent chats',style: TextStyle( fontWeight: FontWeight.w500, fontSize: 26),),
              ],
            ),
    );
  }
}
