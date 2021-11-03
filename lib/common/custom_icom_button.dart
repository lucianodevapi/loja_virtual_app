import 'package:flutter/material.dart';

class CustomIconButtom extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final VoidCallback onTap;

  const CustomIconButtom({
    Key? key,
    required this.iconData,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              iconData,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
