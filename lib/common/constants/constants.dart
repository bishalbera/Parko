import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

const String appName = "Parko";
const String appTagline = "Park, where you want! :)";

// firebase vars

var firestore = FirebaseFirestore.instance;
var firebaseAuth = FirebaseAuth.instance;
var ownerId = FirebaseAuth.instance.currentUser?.uid;

File? imageFile;

var locationData;
