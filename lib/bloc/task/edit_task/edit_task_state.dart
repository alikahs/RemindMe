part of 'edit_task_bloc.dart';

@freezed
class EditTaskState with _$EditTaskState {
  const factory EditTaskState.initial() = _Initial;
  const factory EditTaskState.loading() = _Loading;
  const factory EditTaskState.success(String idTask, TaskModel taskModel) =
      _Success;
  const factory EditTaskState.error(String message) = _Error;
}
