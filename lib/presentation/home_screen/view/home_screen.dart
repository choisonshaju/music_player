import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:FloBeat/core/constant/Textstyle.dart';
import 'package:FloBeat/core/constant/color.dart';
import 'package:FloBeat/presentation/home_screen/controller/controller.dart';
import 'package:FloBeat/presentation/player_screen/view/player_screen.dart';
import 'package:FloBeat/presentation/settings_screen/view/settings_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../miniaudio_controller/mini_audio_player.dart';

class HomeScreen extends StatelessWidget {
  final Playercontroller controller = Get.put(Playercontroller());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didpop) async {
        if (!didpop) {
          final result = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Do You Want To Exit "),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("No"),
                ),
                ElevatedButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: Text("Yes"),
                ),
              ],
            ),
          );
          if (result) {
            exit(0);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text(
            "FloBeat",
            style: title(),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: PopupMenuButton(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SettingsScreen(),
                        ),
                      );
                    },
                    child: Text("SETTINGS"),
                  ),
                ],
                child: Icon(
                  Icons.more_vert,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                autofocus: false,
                cursorColor: Colors.black,
                controller: searchController,
                onChanged: (value) {
                  controller.search(value);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: whiteColor,
                  labelText: "Search Songs",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  hintText: 'Search Songs',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    color: Colors.black,
                    onPressed: () {
                      searchController.clear();
                      controller.search('');
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (controller.songs.isEmpty) {
                    return Center(child: Text("No Song Found", style: text()));
                  } else {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.songs.length,
                      itemBuilder: (BuildContext context, int index) {
                        SongModel song = controller.songs[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              color: Color.fromARGB(87, 0, 0, 0),
                            ),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              title: Text(
                                song.displayNameWOExt,
                                maxLines: 1,
                                style: text(),
                              ),
                              subtitle: Text(
                                song.artist.toString() == "<unknown>"
                                    ? "Unknown Artist"
                                    : song.artist.toString(),
                                style: text(),
                              ),
                              leading: QueryArtworkWidget(
                                id: song.id,
                                type: ArtworkType.AUDIO,
                                artworkFit: BoxFit.cover,
                                nullArtworkWidget: const Icon(
                                  Icons.music_note,
                                  color: whiteColor,
                                  size: 32,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PlayerScreen(
                                      data: controller.songs,
                                    ),
                                  ),
                                );
                                controller.playsong(song.uri, index);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
        floatingActionButton: Obx(
          () => controller.miniPlayerVisible.value
              ? MiniAudioPlayer()
              : SizedBox.shrink(),
        ),
      ),
    );
  }
}
