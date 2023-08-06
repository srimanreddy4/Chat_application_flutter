import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:club_appdev/login.dart' ;
import 'package:cloud_firestore/cloud_firestore.dart';


// Create account function
Future<User?> createAccount(String username, String email, String password) async {
  // Get the Firebase Authentication instance
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new user with the provided email and password
  try {
    User? user = (await auth.createUserWithEmailAndPassword(email: email, password: password)).user ;

    if (user!=null) {
      print('account created succesfully!') ;

      // var name;
      // user.updateDisplayName(displayName: name) ;
      //  User.User!.updateDisplayName(username);
       await user.updateDisplayName(username);

      await _firestore.collection('users').doc(auth.currentUser?.uid).set({
        "name" : username,
        "email" : email,
        "status" : "Unavaliable"


      });
      return user ;

    }
    else {
      print("Account creation failed") ;
      return user ;
    }
    
  } catch (error) {
    // Display an error message
    print('error');
    return null ;
  }
}

// Login function
Future<User?> login(String email, String password) async {
  // Get the Firebase Authentication instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Sign in the user with the provided email and password
  try {
    User? user = (await auth.signInWithEmailAndPassword(email: email, password: password)).user ;
    if (user != null) {
      print('Login succesful') ;
      return user ;
    }
    else {
      print('Login unsuccesful') ;
      return user ;
    }

    // Redirect the user to the home page
   
  } catch (error) {
    // Display an error message
    print('error') ;
    return null ;
  }
}

// Logout function
void logout(BuildContext context) async {
  // Get the Firebase Authentication instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Sign out the current user
  await auth.signOut();
  // ignore: use_build_context_synchronously
  Navigator.push(context, MaterialPageRoute(builder: (_)=> Login())) ;
  
}
