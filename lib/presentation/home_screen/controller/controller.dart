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

  var searchQuery = ''.obs;

  var miniPlayerVisible = false.obs; // State variable for miniplayer visibility

  @override
  void onInit() {
    super.onInit();
    checkPermission();
    initAudioPlayer();
    querySongs();
    // Listen to player state changes
    audioPlayer.playerStateStream.listen((state) {
      isplaying.value = state.playing; // Update isplaying based on player state
      if (state.processingState == ProcessingState.completed) {
        playNext();
        if (searchQuery.isEmpty) {
          playNext();
        }
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
    // Ensure miniplayer remains visible when playing or paused
    audioPlayer.playerStateStream.listen((state) {
      if (state.playing || state.processingState == ProcessingState.completed) {
        miniPlayerVisible.value = true;
      }
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
      await querySongs();
    } else {
      checkPermission();
    }
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  Future<void> querySongs() async {
    List<SongModel> fetchedSongs = await audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    );

    data = fetchedSongs;

    if (searchQuery.isNotEmpty) {
      search(searchQuery.value);
    } else {
      songs.value = data;
    }
  }

  void search(String query) {
    searchQuery.value = query.toLowerCase();
    if (query.isEmpty) {
      songs.value = data;
    } else {
      songs.value = data
          .where((song) =>
              song.title.toLowerCase().contains(query) ||
              song.artist!.toLowerCase().contains(query))
          .toList();
    }
  }

  void closeMiniPlayer() {
    audioPlayer.stop(); // Stop audio playback
    miniPlayerVisible.value = false; // Hide miniplayer
  }
}
