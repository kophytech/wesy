import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:wesy/app/app.dart';

class CustomDataTable extends StatelessWidget {
  const CustomDataTable({
    Key? key,
    this.title,
    this.row,
    this.length = 0,
    this.width = 500,
  }) : super(key: key);

  final List<Widget>? title;
  final IndexedWidgetBuilder? row;
  final int length;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 80,
        rightHandSideColumnWidth: width,
        isFixedHeader: true,
        headerWidgets: title,
        leftSideItemBuilder: (BuildContext context, int index) {
          return ColumnTile(
            text: (index + 1).toString(),
          );
        },
        rightSideItemBuilder: row,
        itemCount: length,
        rowSeparatorWidget: const Divider(color: Colors.grey),
      ),
    );
  }
}
// onPressed: () {
//           sortType = CustomDataTable.sortStatus;
//           isAscending = !isAscending;
//           user.sortStatus(isAscending);
//           setState(() {});
//         },
