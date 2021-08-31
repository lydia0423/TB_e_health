import 'package:flutter/material.dart';

class TitleAppBar extends AppBar {
  TitleAppBar()
      : super(elevation: 0, centerTitle: true, actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: Colors.white,
          )
        ]);
}
