import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/request_model/task/task_request_model.dart';

class TaskLocalDatasources {
  static const String _taskListKey = 'task_list';

  /// Generate id unik sederhana (tanpa package)
  String _genId() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<SharedPreferences> _prefs() => SharedPreferences.getInstance();

  /// Create task baru (auto id kalau kosong)
  Future<TaskModel> createTask(TaskModel task) async {
    final pref = await _prefs();
    final list = pref.getStringList(_taskListKey) ?? [];

    final taskWithId = task.idTask.isNotEmpty
        ? task
        : task.copyWith(idTask: _genId());

    list.add(jsonEncode(taskWithId.toMap()));
    await pref.setStringList(_taskListKey, list);
    return taskWithId;
  }

  /// Ambil semua task
  Future<List<TaskModel>> getAllTasks() async {
    final pref = await _prefs();
    final list = pref.getStringList(_taskListKey) ?? [];
    return list.map((e) => TaskModel.fromMap(jsonDecode(e))).toList();
  }

  /// Ambil task by id
  Future<TaskModel?> getTaskById(String idTask) async {
    final pref = await _prefs();
    final list = pref.getStringList(_taskListKey) ?? [];
    for (final e in list) {
      final t = TaskModel.fromMap(jsonDecode(e));
      if (t.idTask == idTask) return t;
    }
    return null;
  }

  /// Update/replace task by id
  Future<bool> updateTaskById(String idTask, TaskModel updated) async {
    final pref = await _prefs();
    final list = pref.getStringList(_taskListKey) ?? [];

    bool found = false;
    final newList = <String>[];

    for (final e in list) {
      final t = TaskModel.fromMap(jsonDecode(e));
      if (t.idTask == idTask) {
        // pastikan id tidak berubah
        final fixed = updated.copyWith(idTask: idTask);
        newList.add(jsonEncode(fixed.toMap()));
        found = true;
      } else {
        newList.add(e);
      }
    }

    if (found) {
      await pref.setStringList(_taskListKey, newList);
    }
    return found;
  }

  /// Hapus task by id
  Future<bool> deleteTaskById(String idTask) async {
    final pref = await _prefs();
    final list = pref.getStringList(_taskListKey) ?? [];
    final before = list.length;

    final newList = list.where((e) {
      final t = TaskModel.fromMap(jsonDecode(e));
      return t.idTask != idTask;
    }).toList();

    final changed = newList.length != before;
    if (changed) {
      await pref.setStringList(_taskListKey, newList);
    }
    return changed;
  }

  /// Helper: toggle status subtask
  /// - Kalau dari false -> true: set endedAt = now (kalau belum), startedAt tetap yang lama (kalau null, isi now)
  /// - Kalau dari true -> false: kosongkan endedAt
  Future<bool> toggleSubTask({
    required String idTask,
    required int subTaskIndex,
    required bool isCompleted,
  }) async {
    final task = await getTaskById(idTask);
    if (task == null) return false;

    final subs = List<SubTask>.from(task.subTask ?? []);
    if (subTaskIndex < 0 || subTaskIndex >= subs.length) return false;

    final current = subs[subTaskIndex];

    final now = DateTime.now();

    final updatedSub = current.copyWith(
      isCompleted: isCompleted,
      startedAt: current.startedAt ?? (isCompleted ? now : null),
      endedAt: isCompleted ? (current.endedAt ?? now) : null,
    );

    subs[subTaskIndex] = updatedSub;

    final updatedTask = task.copyWith(subTask: subs);
    return updateTaskById(idTask, updatedTask);
  }

  /// (Opsional) Hapus semua task
  Future<void> clearAll() async {
    final pref = await _prefs();
    await pref.remove(_taskListKey);
  }

  // buat delete subtask by index
  Future<bool> deleteSubTaskByIndex({
    required String idTask,
    required int subTaskIndex,
  }) async {
    final task = await getTaskById(idTask);
    if (task == null) return false;

    final subs = List<SubTask>.from(task.subTask ?? []);
    if (subTaskIndex < 0 || subTaskIndex >= subs.length) return false;

    subs.removeAt(subTaskIndex);

    final updatedTask = task.copyWith(subTask: subs);
    return updateTaskById(idTask, updatedTask);
  }
}
