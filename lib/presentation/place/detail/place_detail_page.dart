import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:krokapp_multiplatform/data/pojo/place_detail.dart';
import 'package:krokapp_multiplatform/presentation/place/place_view_model.dart';
import 'package:provider/provider.dart';

class PlaceDetailPage extends StatelessWidget {
  final int placeId;

  PlaceDetailPage({
    required this.placeId,
  });

  @override
  Widget build(BuildContext context) {
    DetailViewModel vm = Provider.of(context);

    return Scaffold(
      body: StreamBuilder<PlaceDetail>(
        stream: vm.getPlaceDetail(placeId),
        builder: (context, placesSnap) {
          if (placesSnap.hasData) {
            var place = placesSnap.data!;
            return Column(
              children: [
                Container(
                  // TODO: Must wrap!
                  height: 300,
                  child: PageView(
                    controller: PageController(),
                    children: place.images.map((e) => Image.network(e)).toList(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: HtmlWidget(place.text),
                ),
              ],
            );
          } else if (placesSnap.hasError) {
            return Center(
              child: Text(placesSnap.error.toString()),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }
}
