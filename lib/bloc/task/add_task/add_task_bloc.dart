import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remind_task/data/datasources/task/task_local_datasources.dart';

import '../../../data/model/request_model/task/task_request_model.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';
part 'add_task_bloc.freezed.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final TaskLocalDatasources taskLocalDatasources;
  AddTaskBloc(this.taskLocalDatasources) : super(_Initial()) {
    on<_AddTask>((event, emit) async {
      emit(_Loading());
      try {
        final created = await taskLocalDatasources.createTask(event.taskModel);
        emit(AddTaskState.success(created));
      } catch (err) {
        emit(AddTaskState.error(err.toString()));
      }
    });
  }
}
