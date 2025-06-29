import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pocket_tasks/model/data/sub_tasksdatabase.dart';
import 'package:pocket_tasks/model/data/taskdatabase.dart';
import 'package:pocket_tasks/model/state_mgt/taskProvider.dart';
import 'package:pocket_tasks/model/theme_mode/theme_Provider.dart';
import 'package:pocket_tasks/view/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskdatabaseAdapter());
  Hive.registerAdapter(SubTasksdatabaseAdapter());

  // await Hive.deleteBoxFromDisk('taskBox'); //uncomment this, if I want my app to delete all tasks on every opening,

  await Hive.openBox<Taskdatabase>('taskBox');
  await Hive.openBox<SubTasksdatabase>('subtaskBox');

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => TaskProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider())
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket Tasks',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
