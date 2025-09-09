import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remind_task/data/datasources/task/task_local_datasources.dart';

part 'edit_submit_subtask_event.dart';
part 'edit_submit_subtask_state.dart';
part 'edit_submit_subtask_bloc.freezed.dart';

class EditSubmitSubtaskBloc
    extends Bloc<EditSubmitSubtaskEvent, EditSubmitSubtaskState> {
  final TaskLocalDatasources taskLocalDatasources;
  EditSubmitSubtaskBloc(this.taskLocalDatasources) : super(_Initial()) {
    on<_EditSubmitSubtask>((event, emit) async {
      emit(const EditSubmitSubtaskState.loading());
      try {
        final ok = await taskLocalDatasources.toggleSubTask(
          idTask: event.idTask,
          subTaskIndex: event.subTaskIndex,
          isCompleted: event.isCompleted,
        );
        emit(EditSubmitSubtaskState.success(ok));
      } catch (e) {
        emit(EditSubmitSubtaskState.error(e.toString()));
      }
    });
  }
}
