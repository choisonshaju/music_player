import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:FloBeat/core/constant/Textstyle.dart';
import 'package:FloBeat/core/constant/color.dart';
import 'package:FloBeat/presentation/home_screen/controller/controller.dart';
import 'package:FloBeat/presentation/miniaudio_controller/mini_audio_player.dart';
import 'package:FloBeat/presentation/player_screen/view/player_screen.dart';
import 'package:FloBeat/presentation/settings_screen/view/settings_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Playercontroller());
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
          "M U S I C  P L A Y E R",
          style: title(),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: PopupMenuButton(
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  ),
                  child: Text("SETTINGS"),
                ),
              ],
              child: Icon(
                Icons.more_vert,
                //size: 28,
              ),
            ),
          )
        ],
      ),

      body: FutureBuilder(
        future: controller.querySongs(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error loading songs: ${snapshot.error}",
                style: text(),
              ),
            );
          } else {
            return Obx(
              () {
                var songs = controller.songs;
                if (songs.isEmpty) {
                  return Center(
                    child: Text(
                      "No Song Found",
                      style: text(),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Stack(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: songs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(10, 10)),
                                  color: Color.fromARGB(87, 0, 0, 0),
                                ),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  title: Text(
                                    songs[index].displayNameWOExt,
                                    maxLines: 1,
                                    style: text(),
                                  ),
                                  subtitle: Text(
                                    songs[index].artist.toString() ==
                                            "<unknown>"
                                        ? "Unknown Artist"
                                        : songs[index].artist.toString(),
                                    style: text(),
                                  ),
                                  leading: QueryArtworkWidget(
                                    id: songs[index].id,
                                    type: ArtworkType.AUDIO,
                                    artworkFit: BoxFit.cover,
                                    nullArtworkWidget: const Icon(
                                      Icons.music_note,
                                      color: whiteColor,
                                      size: 32,
                                    ),
                                  ),
                                  trailing:
                                      controller.playIndex.value == index &&
                                              controller.isplaying.value
                                          ? Icon(
                                              Icons.play_arrow,
                                              color: whiteColor,
                                              size: 26,
                                            )
                                          : null,
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          PlayerScreen(data: songs),
                                    ));

                                    controller.playsong(
                                        songs[index].uri, index);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          }
        },
      ),
      floatingActionButton: MiniAudioPlayer(),
      //  controller.isplaying.value ? MiniAudioPlayer() : null,
    );
  }
}
