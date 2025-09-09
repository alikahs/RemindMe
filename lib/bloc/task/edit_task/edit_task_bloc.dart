import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remind_task/data/datasources/task/task_local_datasources.dart';

import '../../../data/model/request_model/task/task_request_model.dart';

part 'edit_task_event.dart';
part 'edit_task_state.dart';
part 'edit_task_bloc.freezed.dart';

class EditTaskBloc extends Bloc<EditTaskEvent, EditTaskState> {
  final TaskLocalDatasources taskLocalDatasources;
  EditTaskBloc(this.taskLocalDatasources) : super(_Initial()) {
    on<_EditTask>((event, emit) async {});
  }
}
