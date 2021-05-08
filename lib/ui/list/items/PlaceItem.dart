import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/data/Place.dart';

class PlaceItem extends StatelessWidget {
  final Place _place;
  final Function(Place) _onItemClick;
  final Function(Place) _onFavoriteClick;

  PlaceItem(
    this._place,
    this._onItemClick,
    this._onFavoriteClick,
  );

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: () => this._onItemClick(_place),
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
                          _place.title,
                          style: TextStyle(fontSize: 15)
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 16),
                      alignment: Alignment.centerRight,
                      child: _createFavoriteClickableIcon(),
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
          child: Image.network(_place.logo),
        ),
      );

  Widget _createFavoriteClickableIcon() => InkWell(
        customBorder: CircleBorder(),
        onTap: () => this._onFavoriteClick(_place),
        child: Container(
          padding: EdgeInsets.all(8),
          child: _createFavoriteIcon(),
        ),
      );

  Widget _createFavoriteIcon() => _place.isShowFavorite
      ? Icon(
          _place.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: _place.isFavorite ? Colors.red : null,
        )
      : null;

  Widget _createDividerWithPadding() => Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Divider(
          height: 0,
        ),
      );
}
