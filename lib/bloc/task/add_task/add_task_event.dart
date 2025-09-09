part of 'add_task_bloc.dart';

@freezed
class AddTaskEvent with _$AddTaskEvent {
  const factory AddTaskEvent.started() = _Started;
  const factory AddTaskEvent.addTask({required TaskModel taskModel}) = _AddTask;
}
