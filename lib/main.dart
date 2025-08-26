import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remind_task/route/route_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:remind_task/screen/signin/sigin_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'style/theme_style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env');
  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  String supabaseKey = dotenv.env['SUPABASE_KEY'] ?? '';
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeStyle(context),
      home: SiginScreen(),
      getPages: RouteApp.pages,
    );
  }
}
