import 'package:intl/intl.dart';

extension StringX on String {
  String get svg => 'assets/svgs/$this.svg';
  String get pngImage => 'assets/images/$this.png';
  String get capitalizeFirst => isNotEmpty && [0].isNotEmpty
      ? '${this[0].toUpperCase()}${substring(1)}'
      : '';
  String get capitalize =>
      trim().split(' ').map((e) => e.capitalizeFirst).join(' ');

  String get formatDate =>
      '${DateFormat.d().format(DateTime.parse(this))}/${DateFormat.M().format(DateTime.parse(this))}/${DateFormat.y().format(DateTime.parse(this))}';

  String get formatTime => DateFormat.jms().format(DateTime.parse(this));
}
