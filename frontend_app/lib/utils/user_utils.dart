import '../models/user.dart';

String getUserName(int userId, List<User> users) {
  final user = users.firstWhere(
    (u) => u.id == userId,
    orElse: () => User(
      id: 0,
      name: 'Desconocido',
      email: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  );
  return user.name;
}