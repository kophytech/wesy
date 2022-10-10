import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';

class ColumnTile extends StatelessWidget {
  const ColumnTile({
    Key? key,
    required this.text,
    this.width = 100,
    this.isLink = false,
    this.alignment = Alignment.centerLeft,
    this.onTap,
  }) : super(key: key);

  final String text;
  final double width;
  final AlignmentGeometry alignment;
  final bool isLink;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLink ? onTap : null,
      child: Container(
        width: width,
        height: 50,
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: alignment,
        child: Text(
          text,
          style: CsTextStyle.overline.copyWith(
            color: isLink ? CsColors.primary : CsColors.black,
          ),
        ),
      ),
    );
  }
}
