import 'package:cs_storage/cs_storage.dart';

class UserRepository {
  UserRepository({CsStorage? csStorage})
      : _csStorage = csStorage ?? CsStorage();

  final CsStorage _csStorage;

  Future<String> getUser() async {
    final user = await _csStorage.readString('user');
    return user!;
  }
}
