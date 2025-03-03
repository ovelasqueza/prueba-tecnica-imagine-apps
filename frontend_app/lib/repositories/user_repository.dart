import '../services/api_service.dart';
import '../models/user.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository(this.apiService);

  Future<List<User>> getUsers() async {
    return await apiService.getUsers();
  }

  Future<void> registerUser(User user) async {
    await apiService.registerUser(user);
  }
}