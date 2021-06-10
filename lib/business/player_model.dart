import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';

class PlayerModel extends ChangeNotifier {
  final String _url;
  final _audioPlayer = AudioPlayer();
  var _isStarted = false;
  var _isPlaying = false;

  get isPlaying => _isPlaying;

  PlayerModel(
    this._url,
  );

  void onPlayButtonClick() async {
    if (!_isStarted) {
      final result = await _audioPlayer.play(_url);
      if (result == 1) {
        _isStarted = true;
        _isPlaying = true;
        notifyListeners();
      }
      return;
    }

    if (_isPlaying) {
      final result = await _audioPlayer.pause();
      if (result == 1) {
        _isPlaying = false;
        notifyListeners();
      }
    } else {
      final result = await _audioPlayer.resume();
      if (result == 1) {
        _isPlaying = true;
        notifyListeners();
      }
    }
  }

  void onViewDispose() {
    _audioPlayer.dispose();
  }
}
