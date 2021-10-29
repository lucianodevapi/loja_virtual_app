import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  final String initialText;

  const SearchDialog({
    Key? key,
    this.initialText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Stack(
      children: [
        Positioned(
          top: 2,
          left: 6,
          right: 6,
          child: Card(
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                prefixIcon: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: primaryColor,
                  ),
                ),
              ),
              initialValue: initialText,
              textInputAction: TextInputAction.search,
              autofocus: true,
              onFieldSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
            ),
          ),
        )
      ],
    );
  }
}
