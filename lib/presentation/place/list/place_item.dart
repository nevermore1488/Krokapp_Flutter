import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/presentation/place/list/place_list_view_model.dart';
import 'package:provider/provider.dart';

class PlaceItem extends StatelessWidget {
  final Place place;

  PlaceItem({
    required this.place,
  });

  Widget build(BuildContext context) {
    PlaceListViewModel vm = Provider.of(context, listen: false);

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
                    padding: _getItemPadding(),
                    child: Text(
                      place.title,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => vm.onPlaceVisitedClick(place),
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

  EdgeInsets _getItemPadding() => EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8);

  Widget _createLogo() => SizedBox(
        width: 56,
        height: 56,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Image.network(place.logo),
            place.isVisited ? Icon(Icons.check_circle, color: Colors.green) : SizedBox.shrink()
          ],
        ),
      );

  Widget _createFavoriteIcon() => place.isShowFavorite
      ? Icon(
          place.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: place.isFavorite ? Colors.red : Colors.black45,
        )
      : SizedBox.shrink();

  // https://stackoverflow.com/questions/54300081/flutter-popupmenu-on-long-press
  void showContextMenu(BuildContext context, PlaceListViewModel vm, Offset position) {
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
