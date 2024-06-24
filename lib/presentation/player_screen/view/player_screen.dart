import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:music_player/core/constant/Textstyle.dart';
import 'package:music_player/core/constant/color.dart';
import 'package:music_player/presentation/home_screen/controller/controller.dart';

import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatelessWidget {
  final List<SongModel> data;
  const PlayerScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<Playercontroller>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      //backgroundColor: whiteColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: whiteColor,
          ),
        ),
        title: Text(
          "N O W  P L A Y I N G",
          style: title(),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
              colors: [Colors.lightGreen, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(
                () => Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: QueryArtworkWidget(
                    id: data[controller.playIndex.value].id,
                    artworkFit: BoxFit.cover,
                    type: ArtworkType.AUDIO,
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                    nullArtworkWidget: Icon(
                      Icons.music_note,
                      size: 70,
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 12,
              // ),
              Obx(
                () => SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        data[controller.playIndex.value].displayNameWOExt,
                        textAlign: TextAlign.center,
                        // overflow: TextOverflow.ellipsis,
                        // maxLines: 2,
                        style: TextStyle(
                            color: bgColor,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        data[controller.playIndex.value].artist.toString() ==
                                "<unknown>"
                            ? "Unknown Artist"
                            : data[controller.playIndex.value]
                                .artist
                                .toString(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: bgColor,
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Text(
                              controller.position.value,
                              style: TextStyle(color: bgColor),
                            ),
                            Expanded(
                              child: Slider(
                                thumbColor: sliderColor,
                                inactiveColor: bgColor,
                                activeColor: sliderColor,
                                min: Duration(seconds: 0).inSeconds.toDouble(),
                                max: controller.max.value,
                                value: controller.value.value,
                                onChanged: (newValue) {
                                  controller.changePosition(newValue.toInt());
                                  newValue = newValue;
                                },
                              ),
                            ),
                            Text(
                              controller.duration.value,
                              style: TextStyle(color: bgColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(color: Colors.white30),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white30, blurRadius: 5),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    controller.playsong(
                                        data[controller.playIndex.value - 1]
                                            .uri,
                                        controller.playIndex.value - 1);
                                  },
                                  icon: Icon(
                                    Icons.skip_previous_rounded,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(color: Colors.white30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.white30, blurRadius: 5),
                                    ],
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        if (controller.isplaying.value) {
                                          controller.audioPlayer.pause();
                                          controller.isplaying(false);
                                        } else {
                                          controller.audioPlayer.play();
                                          controller.isplaying(true);
                                        }
                                      },
                                      icon: controller.isplaying.value
                                          ? Icon(
                                              Icons.pause,
                                              size: 30,
                                              color: Colors.white,
                                            )
                                          : Icon(
                                              Icons.play_arrow_rounded,
                                              color: bgDarkColor,
                                              size: 30,
                                            )),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(color: Colors.white30),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white30, blurRadius: 5),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    controller.playsong(
                                        data[controller.playIndex.value + 1]
                                            .uri,
                                        controller.playIndex.value + 1);
                                  },
                                  icon: Icon(
                                    Icons.skip_next_rounded,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
