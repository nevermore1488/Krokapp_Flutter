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

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: () => this.onItemClick(context, place),
      child: Column(
        children: [
          Stack(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      _createLogo(),
                      Text(
                        place.title,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 16),
                      alignment: Alignment.centerRight,
                      child: _createFavoriteClickableIcon(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
          _createDividerWithPadding(),
        ],
      ));

  Widget _createLogo() => Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: SizedBox(
          width: 60,
          height: 60,
          child: Image.network(place.logo),
        ),
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
