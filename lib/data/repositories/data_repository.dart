import '../../core/constants/constant_text.dart';
import '../model/user.dart';

class DataRepository {

  Future<bool> checkLogin(String email, String pass) async {
    return email == emailConstant && pass == passConstant;
  }

  Future<List<User>> usersRepository() async {
    return users;
  }
}
