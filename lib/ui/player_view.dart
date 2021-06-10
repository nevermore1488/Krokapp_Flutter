import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:krokapp_multiplatform/business/player_model.dart';
import 'package:provider/provider.dart';

class PlayerView extends StatefulWidget {
  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  PlayerModel? model;

  @override
  Widget build(BuildContext context) => Consumer<PlayerModel>(builder: (context, value, child) {
        model = value;
        return Container(
          padding: EdgeInsets.all(8),
          child: ElevatedButton(
            onPressed: value.onPlayButtonClick,
            style: ElevatedButton.styleFrom(shape: CircleBorder(), primary: Colors.orange),
            child: SizedBox(
              width: 56,
              height: 56,
              child: Icon(
                value.isPlaying ? Icons.pause : Icons.play_arrow_outlined,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
        );
      });

  @override
  void dispose() {
    model?.onViewDispose();
    super.dispose();
  }
}
