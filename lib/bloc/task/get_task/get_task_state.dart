part of 'get_task_bloc.dart';

@freezed
class GetTaskState with _$GetTaskState {
  const factory GetTaskState.initial() = _Initial;
  const factory GetTaskState.loading() = _Loading;
  const factory GetTaskState.loaded(List<TaskModel> tasks) = _Loaded;
  const factory GetTaskState.error(String message) = _Error;
}
