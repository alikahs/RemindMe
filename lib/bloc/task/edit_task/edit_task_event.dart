part of 'edit_task_bloc.dart';

@freezed
class EditTaskEvent with _$EditTaskEvent {
  const factory EditTaskEvent.started() = _Started;
  const factory EditTaskEvent.editTask({
    required String idTask,
    required TaskModel taskBaru,
  }) = _EditTask;
}
