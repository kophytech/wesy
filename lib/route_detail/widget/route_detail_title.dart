import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';

class RouteDetailsTitle extends StatelessWidget {
  const RouteDetailsTitle({
    Key? key,
    required this.title,
    this.isLoading = false,
    this.hasAddButton = true,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final bool isLoading;
  final bool hasAddButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: CsTextStyle.headline4,
        ),
        if (hasAddButton)
          InkResponse(
            onTap: onTap,
            child: const CircleAvatar(
              radius: 15,
              backgroundColor: CsColors.primary,
              child: Icon(
                Icons.add,
                color: CsColors.white,
                size: 25,
              ),
            ),
          ),
      ],
    );
  }
}
