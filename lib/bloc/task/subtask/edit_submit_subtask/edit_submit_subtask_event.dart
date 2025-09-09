part of 'edit_submit_subtask_bloc.dart';

@freezed
class EditSubmitSubtaskEvent with _$EditSubmitSubtaskEvent {
  const factory EditSubmitSubtaskEvent.started() = _Started;
  const factory EditSubmitSubtaskEvent.editSubmitSubtask({
    required String idTask,
    required int subTaskIndex,
    required bool isCompleted,
  }) = _EditSubmitSubtask;
}
