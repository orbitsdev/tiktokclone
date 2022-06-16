


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

var firebaseauth =  FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore =  FirebaseFirestore.instance;
String? uid =  firebaseauth.currentUser!.uid; 


//firestore
CollectionReference userrefference = firestore.collection('users');
CollectionReference videofference = firestore.collection('videos');

//firestorage

Reference profilestoragerefference = firebaseStorage.ref().child('profilephotos');
Reference videosstoragerefference = firebaseStorage.ref().child('videos');
Reference thumbnailsstoragerefference = firebaseStorage.ref().child('thumbnails');
