import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    this.fullName,
    this.userId,
  });
  final String? fullName;
  final String? userId;

  String farmerAsString() {
    return '#$userId $fullName';
  }

  bool farmerFilterByName(String filter) {
    return fullName?.toString().toLowerCase().contains(filter) ?? false;
  }

  @override
  List<Object?> get props => [fullName, userId];
}
