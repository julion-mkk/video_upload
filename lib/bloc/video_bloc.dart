/*
import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_upload/bloc/video_event.dart';

class VideoBloc {
  ListResult? _videoList;

  final _videoController = StreamController<ListResult>();

  StreamSink<ListResult>? get _videos => _videoController.sink;

  Stream<ListResult>? get videos => _videoController.stream;

  final _videoEventController = StreamController<VideoEvent>();

  Sink<VideoEvent> get videoEventSink => _videoEventController.sink;

  VideoBloc() {
    _videoEventController.stream.listen((event) { })
  }
}*/
