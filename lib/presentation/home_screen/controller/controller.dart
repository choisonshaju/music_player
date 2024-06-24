import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class Playercontroller extends GetxController {
  var songs = List<SongModel>.empty().obs;
  static List<SongModel> data = [];

  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  var playIndex = 0.obs;
  var isplaying = false.obs;

  var duration = ''.obs;
  var position = ''.obs;

  var max = 0.0.obs;
  var value = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
    initAudioPlayer();
    audioPlayer.playerStateStream.listen((State) {
      if (State.processingState == ProcessingState.completed) {
        playNext();
      }
    });
  }

  void initAudioPlayer() {
    audioPlayer.durationStream.listen((d) {
      duration.value = d.toString().split(".")[0];
      max.value = d!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((p) {
      position.value = p.toString().split(".")[0];
      value.value = p.inSeconds.toDouble();
    });
    audioPlayer.playerStateStream.listen((state) {
      isplaying.value = state.playing;
    });
  }

  void playsong(String? uri, int index) async {
    playIndex.value = index;
    try {
      await audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(uri!)),
      );
      audioPlayer.play();
    } catch (e) {
      print('Error playing song: $e');
    }
  }

  void pause() {
    audioPlayer.pause();
  }

  void resume() {
    audioPlayer.play();
  }

  void playNext() async {
    List<SongModel> songs = await audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    );
    if (playIndex.value < songs.length - 1) {
      playIndex.value++;
      playsong(songs[playIndex.value].uri, playIndex.value);
    }
  }

  void playPrevious() async {
    List<SongModel> songs = await audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    );
    if (playIndex.value > 0) {
      playIndex.value--;
      playsong(songs[playIndex.value].uri, playIndex.value);
    }
  }

  void changePosition(int seconds) {
    Duration position = Duration(seconds: seconds);
    audioPlayer.seek(position);
  }

  void checkPermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
      // Permission granted, do nothing
    } else {
      // Permission not granted, request again
      checkPermission();
    }
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  Future<void> querySongs() async {
    songs.value = await audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    );
  }
}
