import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';

class PlaceItem extends StatelessWidget {
  final Place place;
  final Function(BuildContext, Place) onItemClick;
  final Function(BuildContext, Place) onFavoriteClick;

  PlaceItem({
    required this.place,
    required this.onItemClick,
    required this.onFavoriteClick,
  });

  Widget build(BuildContext context) => InkWell(
        onTap: () => this.onItemClick(context, place),
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
                  _createFavoriteClickableIcon(context),
                ],
              ),
            ),
            _createDividerWithPadding(),
          ],
        ),
      );

  EdgeInsets _getItemPadding() => EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8);

  Widget _createLogo() => SizedBox(
        width: 56,
        height: 56,
        child: Image.network(place.logo),
      );

  Widget _createFavoriteClickableIcon(BuildContext context) => IconButton(
        onPressed: () => this.onFavoriteClick(context, place),
        icon: _createFavoriteIcon(),
      );

  Widget _createFavoriteIcon() => place.isShowFavorite
      ? Icon(
          place.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: place.isFavorite ? Colors.red : Colors.black45,
        )
      : SizedBox.shrink();

  Widget _createDividerWithPadding() => Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Divider(
          height: 0,
        ),
      );
}
