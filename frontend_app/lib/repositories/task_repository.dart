import '/services/api_service.dart';
import '/models/task.dart';


class TaskRepository {
  final ApiService apiService;

  TaskRepository(this.apiService);

  Future<List<Task>> fetchTasks() async {
    return await apiService.getTasks();
  }

  Future<void> deleteTask(int taskId) async {
    await apiService.deleteTask(taskId);
  }

   Future<void> createTask(Task task) async {
    await apiService.createTask(task);
  }

  Future<void> updateTask(int taskId, Task task) async {
    await apiService.updateTask(taskId, task);
  }
}