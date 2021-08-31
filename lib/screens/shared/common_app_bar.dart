import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CommonAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
        )
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(60.0);
}
