import 'package:flutter/material.dart';

class InfoCardWidget extends StatelessWidget {
  final String primaryText;
  final String secondaryText;

  InfoCardWidget({
    required this.primaryText,
    required this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(primaryText),
      subtitle: Text(secondaryText),
      leading: Icon(
        Icons.label,
        color: Colors.grey[400],
      ),
    );
  }
}
