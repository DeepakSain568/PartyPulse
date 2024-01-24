import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Services {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore database = FirebaseFirestore.instance;
 static final FirebaseStorage _storage = FirebaseStorage.instance;
  static FirebaseAuth get Authobject => _auth;
  static FirebaseStorage get Storage => _storage;
  
}
