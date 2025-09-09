part of 'edit_submit_subtask_bloc.dart';

@freezed
class EditSubmitSubtaskState with _$EditSubmitSubtaskState {
  const factory EditSubmitSubtaskState.initial() = _Initial;
  const factory EditSubmitSubtaskState.loading() = _Loading;
  const factory EditSubmitSubtaskState.success(bool isDone) = _Success;
  const factory EditSubmitSubtaskState.error(String message) = _Error;
}
