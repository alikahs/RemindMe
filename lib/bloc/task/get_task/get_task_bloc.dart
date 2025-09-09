import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/datasources/task/task_local_datasources.dart';
import '../../../data/model/request_model/task/task_request_model.dart';

part 'get_task_event.dart';
part 'get_task_state.dart';
part 'get_task_bloc.freezed.dart';

class GetTaskBloc extends Bloc<GetTaskEvent, GetTaskState> {
  final TaskLocalDatasources taskLocalDatasources;
  GetTaskBloc(this.taskLocalDatasources) : super(_Initial()) {
    on<_GetTasks>((event, emit) async {
      emit(const GetTaskState.loading());
      try {
        final tasks = await taskLocalDatasources.getAllTasks();
        emit(_Loaded(tasks));
      } catch (err) {
        emit(_Error(err.toString()));
      }
    });
  }
}
