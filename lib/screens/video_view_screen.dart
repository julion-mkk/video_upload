import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_upload/provider/video_provider.dart';
import 'package:video_upload/screens/video_play_screen.dart';


class VideoViewScreen extends StatefulWidget {
  @override
  _VideoViewScreenState createState()=> _VideoViewScreenState();
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  PlatformFile? pickedFile;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    //await getVideos();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      getVideos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<VideoProvider>(
        builder: (_,data,child){
          return FutureBuilder<ListResult>(
            future: data.videoList,
            builder: (_,snapshot) {
              if(snapshot.hasData) {
                final files = snapshot.data!.items;
                return ListView.builder(
                  itemCount: files.length,
                  itemBuilder: (_,index){
                    final file = files[index];
                    return GestureDetector(
                      onTap: () async{
                        String url = await file.getDownloadURL();
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=> VideoPlayScreen(url)));
                      },
                      child: Card(
                        margin: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              child: Icon(Icons.ondemand_video_outlined),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(file.name,style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if(snapshot.hasError) {
                return const Text('Has Error');
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          //Provider.of<VideoProvider>(context,listen: false).getVideoList();
          await _uploadFile();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _uploadFile() async {
    final result = await FilePicker.platform.pickFiles();
    if(result != null) {
      pickedFile = result.files.first;
      final path = 'videos/${pickedFile!.name}';
      final file = File(pickedFile!.path!);
      final res = FirebaseStorage.instance.ref().child(path);
      await res.putFile(file).whenComplete((){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Video added successfully.')));
        getVideos();
      });
    }
  }

  getVideos() async {
    await Provider.of<VideoProvider>(context,listen: false).getVideoList();
  }
}