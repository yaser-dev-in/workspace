import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UserService {
  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? '';
    if (userId.isEmpty) {
      userId = const Uuid().v4();
      await prefs.setString('userId', userId);
    }
    return userId;
  }
}
