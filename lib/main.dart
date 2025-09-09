import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remind_task/bloc/auth/logout_bloc/logout_bloc.dart';
import 'package:remind_task/bloc/task/get_task/get_task_bloc.dart';
import 'package:remind_task/firebase_options.dart';
import 'package:remind_task/route/route_app.dart';
import 'package:remind_task/screen/signin/sigin_screen.dart';
import 'bloc/auth/login_bloc/login_bloc.dart';
import 'bloc/task/add_task/add_task_bloc.dart';
import 'bloc/task/subtask/edit_submit_subtask/edit_submit_subtask_bloc.dart';
import 'data/datasources/auth/auth_remote_datasources.dart';
import 'data/datasources/task/task_local_datasources.dart';
import 'style/theme_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: defaultFirebaseOptions);
  // await dotenv.load(fileName: 'assets/.env');
  // String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  // String supabaseKey = dotenv.env['SUPABASE_KEY'] ?? '';
  // await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(AuthRemoteDataSource())),
        BlocProvider(create: (context) => LogoutBloc(AuthRemoteDataSource())),
        BlocProvider(create: (context) => GetTaskBloc(TaskLocalDatasources())),
        BlocProvider(create: (context) => AddTaskBloc(TaskLocalDatasources())),
        BlocProvider(
          create: (context) => EditSubmitSubtaskBloc(TaskLocalDatasources()),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeStyle(context),
        home: SiginScreen(),
        getPages: RouteApp.pages,
      ),
    );
  }
}
