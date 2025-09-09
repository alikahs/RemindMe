part of 'get_task_bloc.dart';

@freezed
class GetTaskEvent with _$GetTaskEvent {
  const factory GetTaskEvent.started() = _Started;
  const factory GetTaskEvent.getTasks() = _GetTasks;
}
