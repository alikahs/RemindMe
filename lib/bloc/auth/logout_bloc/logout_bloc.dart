import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/datasources/auth/auth_remote_datasources.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRemoteDataSource authRemoteDataSource;
  LogoutBloc(this.authRemoteDataSource) : super(_Initial()) {
    on<_Logout>((event, emit) async {
      emit(_Loading());
      try {
        await authRemoteDataSource.logout(event.uuid);
        emit(_Success("Logout successful"));
      } catch (e) {
        emit(_Error("Logout failed"));
      }
    });
  }
}
