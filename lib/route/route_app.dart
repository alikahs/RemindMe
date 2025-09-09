import 'package:get/get.dart';
import 'package:remind_task/screen/home_screen.dart';
import 'package:remind_task/screen/signin/sigin_screen.dart';
import 'package:remind_task/screen/task/detail_task_screen.dart';
import 'package:remind_task/screen/task/edit_task_screen.dart';
import '../screen/profile/profile_screen.dart';
import '../screen/task/add_task_screen.dart';
import '../screen/timer_focus/timer_screen.dart';
import 'route_name.dart';

class RouteApp {
  static final pages = [
    GetPage(
      name: RouteName.home,
      page: () => const HomeScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.detailTask,
      page: () => const DetailTaskScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.editTask,
      page: () => const EditTaskScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.addTask,
      page: () => const AddTaskScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.timer,
      page: () => const TimerScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.profile,
      page: () => const ProfileScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.login,
      page: () => const SiginScreen(),
      transition: Transition.fade,
    ),
  ];
}
