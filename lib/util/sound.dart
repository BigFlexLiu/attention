import 'package:audioplayers/audioplayers.dart';

void playPianoDescent() async {
  final player = AudioPlayer();
  await player.play(AssetSource('audio/piano_descent.mp3'));
}
