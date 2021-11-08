import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:krokapp_multiplatform/resources.dart';
import 'package:krokapp_multiplatform/ui/player_model.dart';
import 'package:provider/provider.dart';

class PlayerView extends StatefulWidget {
  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  PlayerModel? model;

  @override
  Widget build(BuildContext context) =>
      Consumer<PlayerModel>(builder: (context, value, child) {
        model = value;
        return ElevatedButton(
          onPressed: value.onPlayButtonClick,
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(), primary: Provider.of<Resources>(context).colorPrimary),
          child: SizedBox(
            width: 56,
            height: 56,
            child: Icon(
              value.isPlaying ? Icons.pause : Icons.play_arrow_outlined,
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
