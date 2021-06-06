import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:krokapp_multiplatform/data/pojo/place_detail.dart';
import 'package:krokapp_multiplatform/presentation/place/detail/place_detail_view_model.dart';
import 'package:krokapp_multiplatform/ui/snapshot_view.dart';
import 'package:provider/provider.dart';

class PlaceDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlaceDetailViewModel vm = Provider.of(context);

    return Scaffold(
      body: StreamBuilder<PlaceDetail>(
        stream: vm.getPlaceDetail(),
        builder: (context, snapshot) => SnapshotView<PlaceDetail>(
            snapshot: snapshot,
            onHasData: (data) => ListView(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: PageView(
                        controller: PageController(),
                        children: data.images.map((e) => Image.network(e)).toList(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: HtmlWidget(data.text),
                    ),
                  ],
                )),
      ),
    );
  }
}
