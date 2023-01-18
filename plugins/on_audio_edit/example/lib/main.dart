/*
=============
Author: Lucas Josino
Github: https://github.com/LucJosin
Website: https://www.lucasjosino.com/
=============
Plugin/Id: on_audio_edit#3
Homepage: https://github.com/LucJosin/on_audio_edit
Pub: https://pub.dev/packages/on_audio_edit
License: https://github.com/LucJosin/on_audio_edit/blob/main/LICENSE
Copyright: © 2021, Lucas Josino. All rights reserved.
=============
*/

import 'package:flutter/material.dart';
import 'package:on_audio_edit/on_audio_edit.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_toast_widget/on_toast_widget.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  // OnAudioQuery instance
  final OnAudioQuery _audioQuery = OnAudioQuery();
  // OnAudioQuery instance
  final OnAudioEdit _audioEdit = OnAudioEdit();

  // Texts controllers
  TextEditingController name = TextEditingController();
  TextEditingController artist = TextEditingController();

  // OnToastWidget animation controller
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );

  // Main parameters
  List<SongModel> songList = [];
  bool? result;

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  requestPermission() async {
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuery.permissionsRequest();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Songs"),
          elevation: 2,
        ),
        body: Stack(
          children: [
            FutureBuilder<List<SongModel>>(
              future: _audioQuery.querySongs(),
              builder: (context, item) {
                // Loading content
                if (item.data == null) return const CircularProgressIndicator();

                // When you try "query" without asking for [READ] or [Library] permission
                // the plugin will return a [Empty] list.
                if (item.data!.isEmpty) return const Text("Nothing found!");

                songList = item.data!;
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: ListView.builder(
                    itemCount: songList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        // [onTap] will open a dialog with two options:
                        //
                        // * Edit audio tags.
                        // * Edit audio artwork.
                        onTap: () => optionsDialog(context, index),
                        // [onLongPress] will read all information about selected items:
                        title: Text(songList[index].title),
                        subtitle: Text(
                          songList[index].artist ?? '<No artist>',
                        ),
                        trailing: const Icon(Icons.arrow_forward_rounded),
                        leading: QueryArtworkWidget(
                          id: songList[index].id,
                          type: ArtworkType.AUDIO,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            OnToastWidget(
              effectType: EffectType.SLIDE,
              slidePositionType: SlidePositionType.BOTTOM,
              controller: _controller,
              child: Container(
                color: result == true ? Colors.green : Colors.red,
                height: 60,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(result.toString()),
                    const SizedBox(height: 10),
                    Text(result == true
                        ? "Pull to refresh to see the magic happening"
                        : "Opps, something wrong happened")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  optionsDialog(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Choose a option"),
          content: SizedBox(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  title: const Text("Edit Audio"),
                  onTap: () {
                    Navigator.pop(context);
                    editAudioDialog(context, index);
                  },
                ),
                ListTile(
                  title: const Text("Edit Artwork"),
                  onTap: () async {
                    Navigator.pop(context);
                    result = await _audioEdit.editArtwork(
                      songList[index].data,
                    );
                    setState(() {
                      _controller.forward();
                    });
                  },
                )
              ],
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            )
          ],
        );
      },
    );
  }

  editAudioDialog(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Change info"),
          content: SizedBox(
            height: 120,
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: artist,
                )
              ],
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () async {
                Map<TagType, dynamic> tag = {
                  TagType.TITLE: name.text,
                  TagType.ARTIST: artist.text,
                };
                Navigator.pop(context);
                result = await _audioEdit.editAudio(
                  songList[index].data,
                  tag,
                  searchInsideFolders: true,
                );
                setState(() {
                  _controller.forward();
                });
              },
              child: const Text("Create"),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            )
          ],
        );
      },
    );
  }
}
