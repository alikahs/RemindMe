part of 'add_task_bloc.dart';

@freezed
class AddTaskState with _$AddTaskState {
  const factory AddTaskState.initial() = _Initial;
  const factory AddTaskState.loading() = _Loading;
  const factory AddTaskState.success(TaskModel taskModel) = _Success;
  const factory AddTaskState.error(String message) = _Error;
}
