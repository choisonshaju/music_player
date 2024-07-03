import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:FloBeat/presentation/home_screen/controller/controller.dart';
import 'package:FloBeat/presentation/player_screen/view/player_screen.dart';

class MiniAudioPlayer extends StatelessWidget {
  final Playercontroller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.miniPlayerVisible.value,
        child: Padding(
          padding: const EdgeInsets.only(left: 33),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlayerScreen(data: controller.songs),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [Colors.lightGreen, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: EdgeInsets.all(16),
              height: 110,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Obx(
                      () => Text(
                        controller.songs.isNotEmpty
                            ? controller.songs[controller.playIndex.value].title
                            : "",
                        maxLines: 1,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
