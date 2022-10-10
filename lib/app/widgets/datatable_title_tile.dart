import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';

class DataTableTitleTile extends StatelessWidget {
  const DataTableTitleTile({
    Key? key,
    required this.text,
    this.width = 100,
    this.onPressed,
    this.sortType = 0,
    this.isSort = false,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  final String text;
  final double width;
  final VoidCallback? onPressed;
  final int sortType;
  final bool isSort;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        width: width,
        height: 50,
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: alignment,
        child: Text(
          '$text ${isSort ? '↑' : ''}',
          style: CsTextStyle.bodyText1.copyWith(
            color: CsColors.black,
            fontWeight: CsFontWeight.bold,
          ),
        ),
      ),
    );
  }
}
