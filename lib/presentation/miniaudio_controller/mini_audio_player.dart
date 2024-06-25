import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/presentation/home_screen/controller/controller.dart';
import 'package:music_player/presentation/player_screen/view/player_screen.dart';

class MiniAudioPlayer extends StatelessWidget {
  final Playercontroller controller = Get.find();
  final Playercontroller data = Playercontroller();
  final controller1 = Get.put(Playercontroller());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 33),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PlayerScreen(data: controller1.songs),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                  colors: [Colors.lightGreen, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          padding: EdgeInsets.all(16),
          height: 101,
          child: Obx(
            () {
              var currentSong = controller.songs.isNotEmpty
                  ? controller.songs[controller.playIndex.value]
                  : null;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      currentSong != null ? currentSong.title : "",
                      maxLines: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.skip_previous, color: Colors.white),
                        onPressed: () {
                          controller.playPrevious();
                        },
                      ),
                      Obx(
                        () => IconButton(
                          icon: Icon(
                            controller.isplaying.value
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (controller.isplaying.value) {
                              controller.pause();
                            } else {
                              controller.resume();
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_next, color: Colors.white),
                        onPressed: () {
                          controller.playNext();
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
