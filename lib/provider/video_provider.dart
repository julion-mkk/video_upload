import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoProvider extends ChangeNotifier {
  Future<ListResult>? videoList;

  getVideoList() async {
    videoList = FirebaseStorage.instance.ref("videos").listAll();
    notifyListeners();
  }
}