import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/presentation/places/places_view_model.dart';
import 'package:provider/provider.dart';

class PlaceItem extends StatelessWidget {
  final Place place;

  PlaceItem({
    required this.place,
  });

  Widget build(BuildContext context) {
    PlacesViewModel vm = Provider.of(context, listen: false);

    late TapDownDetails tapDownDetails;
    return InkWell(
      onTap: () => vm.onPlaceClick(place),
      onTapDown: (details) => tapDownDetails = details,
      onLongPress: () => showContextMenu(context, vm, tapDownDetails.globalPosition),
      child: Column(
        children: [
          Container(
            padding: _getItemPadding(),
            child: Row(
              children: [
                _createLogo(),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
                    child: Text(
                      place.title,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => vm.onPlaceFavoriteClick(place),
                  icon: _createFavoriteIcon(),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Divider(
              height: 0,
            ),
          ),
        ],
      ),
    );
  }

  EdgeInsets _getItemPadding() => EdgeInsets.only(
        left: 16,
        right: 8,
        top: 8 + getPaddingDifference(),
        bottom: 8 + getPaddingDifference(),
      );

  Widget _createLogo() => SizedBox(
        width: 56 - getPaddingDifference(),
        height: 56 - getPaddingDifference(),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Image.network(place.logo),
            place.isVisited ? Icon(Icons.check_circle, color: Colors.green) : SizedBox.shrink()
          ],
        ),
      );

  double getPaddingDifference() => (place.type == PlaceType.city ? 8 : 0);

  Widget _createFavoriteIcon() => place.isShowFavorite
      ? Icon(
          place.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: place.isFavorite ? Colors.red : null,
        )
      : SizedBox.shrink();

  // https://stackoverflow.com/questions/54300081/flutter-popupmenu-on-long-press
  void showContextMenu(BuildContext context, PlacesViewModel vm, Offset position) {
    if (!place.isShowVisited) return;

    var isVisitedValue = place.isVisited
        ? AppLocalizations.of(context)!.was_not_here
        : AppLocalizations.of(context)!.was_here;

    final RenderBox overlay = Overlay.of(context)!.context.findRenderObject()! as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromRect(
          position & const Size(40, 40), // smaller rect, the touch area
          Offset.zero & overlay.semanticBounds.size // Bigger rect, the entire screen
          ),
      items: [
        PopupMenuItem<String>(
          value: isVisitedValue,
          child: Text(isVisitedValue),
        )
      ],
    ).then((value) {
      if (value == isVisitedValue) {
        vm.onPlaceVisitedClick(place);
      }
    });
  }
}
