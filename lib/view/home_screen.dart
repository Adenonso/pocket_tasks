import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pocket_tasks/model/data/database.dart';
import 'package:pocket_tasks/model/data/taskdatabase.dart';
import 'package:pocket_tasks/model/state_mgt/taskProvider.dart';
import 'package:pocket_tasks/view/task_detail_screen.dart';
import 'package:pocket_tasks/widgets/my_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Database db = Database();

  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        scrolledUnderElevation: 20,
        title: Text(
          "Pocket tasks",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: tasks.isEmpty
          ? Center(child: Text('No tasks yet'))
          : ValueListenableBuilder(
              valueListenable: Hive.box<Taskdatabase>('taskBox').listenable(),
              builder: (context, Box<Taskdatabase> box, _) {
                // get all keys and values
                List<int> allKeys = box.keys.cast<int>().toList();
                List<Taskdatabase> allTasks = box.values.toList();

                // Filter/sort keys and tasks together
                if (selectedCategory == 'Active') {
                  final filtered = allTasks
                      .asMap()
                      .entries
                      .where((entry) => !(entry.value.isCompleted ?? false))
                      .toList();
                  allTasks = filtered.map((e) => e.value).toList();
                  allKeys = filtered.map((e) => allKeys[e.key]).toList();
                } else if (selectedCategory == 'Completed') {
                  final filtered = allTasks
                      .asMap()
                      .entries
                      .where((entry) => (entry.value.isCompleted ?? false))
                      .toList();
                  allTasks = filtered.map((e) => e.value).toList();
                  allKeys = filtered.map((e) => allKeys[e.key]).toList();
                } else if (selectedCategory == 'Latest') {
                  final filtered = allTasks
                      .asMap()
                      .entries
                      .where((entry) =>
                          entry.value.createdAt != null &&
                          entry.value.createdAt!.isAfter(
                              DateTime.now().subtract(Duration(days: 7))))
                      .toList();
                  allTasks = filtered.map((e) => e.value).toList();
                  allKeys = filtered.map((e) => allKeys[e.key]).toList();
                } else if (selectedCategory == 'Newest') {
                  final zipped = allTasks.asMap().entries.toList();
                  zipped.sort((a, b) => (b.value.createdAt ?? DateTime(0))
                      .compareTo(a.value.createdAt ?? DateTime(0)));
                  allTasks = zipped.map((e) => e.value).toList();
                  allKeys = zipped.map((e) => allKeys[e.key]).toList();
                } else if (selectedCategory == 'Oldest') {
                  final zipped = allTasks.asMap().entries.toList();
                  zipped.sort((a, b) => (a.value.createdAt ?? DateTime(0))
                      .compareTo(b.value.createdAt ?? DateTime(0)));
                  allTasks = zipped.map((e) => e.value).toList();
                  allKeys = zipped.map((e) => allKeys[e.key]).toList();
                }

                return Column(
                  children: [
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ChoiceChip(
                              label: Text('All'),
                              selected: selectedCategory == 'All',
                              onSelected: (value) => setState(() {
                                selectedCategory = 'All';
                              }),
                            ),
                            SizedBox(width: 8),
                            ChoiceChip(
                              label: Text('Active'),
                              selected: selectedCategory == 'Active',
                              onSelected: (_) =>
                                  setState(() => selectedCategory = 'Active'),
                            ),
                            SizedBox(width: 8),
                            ChoiceChip(
                              label: Text('Completed'),
                              selected: selectedCategory == 'Completed',
                              onSelected: (_) => setState(
                                  () => selectedCategory = 'Completed'),
                            ),
                            SizedBox(width: 8),
                            ChoiceChip(
                              label: Text('Newest'),
                              selected: selectedCategory == 'Newest',
                              onSelected: (_) =>
                                  setState(() => selectedCategory = 'Newest'),
                            ),
                            SizedBox(width: 8),
                            ChoiceChip(
                              label: Text('Oldest'),
                              selected: selectedCategory == 'Oldest',
                              onSelected: (_) =>
                                  setState(() => selectedCategory = 'Oldest'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: allTasks.length,
                        itemBuilder: (context, index) {
                          final task = allTasks[index];
                          final key = allKeys[index];
                          return Container(
                            padding: EdgeInsets.all(15),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  side:
                                      BorderSide(width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15)),
                              tileColor:
                                  Theme.of(context).colorScheme.background,
                              title:
                                  Text(task.title, style: GoogleFonts.inter()),
                              leading: IconButton(
                                  onPressed: () {
                                    _showEditTaskDialog(context, key, task);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 18,
                                  )),
                              trailing: Checkbox(
                                  value: task.isCompleted,
                                  onChanged: (value) {
                                    setState(() {
                                      task.isCompleted = value!;
                                      db.updateTaskdatabase(key, task);
                                    });
                                  }),
                              subtitle: Text(
                                task.isCompleted == true
                                    ? 'Completed'
                                    : 'Active',
                                style: GoogleFonts.inter(),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TaskDetailScreen(
                                            task: task, index: key)));
                              },
                              onLongPress: () {
                                _showDeleteDialog(context, key, task);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          onPressed: () {
            _showAddTaskDialog(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  //TO ADD A NEW TASK
  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          title: Text(
            'Add Task',
            style:
                GoogleFonts.inter(color: Theme.of(context).colorScheme.primary),
          ),
          content: SizedBox(
            height: 120,
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: 'Task Title',
                      hintStyle: GoogleFonts.inter(
                          color: Theme.of(context).colorScheme.primary)),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final newTask = Taskdatabase(
                    title: controller.text,
                    noteContents: [],
                    createdAt: DateTime.timestamp(),
                    isCompleted: false);

                Provider.of<TaskProvider>(context, listen: false)
                    .addTask(newTask);

                Navigator.pop(context);
              },
              child: Text(
                'Add',
                style: GoogleFonts.inter(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //TO EDIT AN EXISTING TASK
  void _showEditTaskDialog(BuildContext context, int key, Taskdatabase task) {
    final TextEditingController controller =
        TextEditingController(text: task.title);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            'Edit Task',
            style: GoogleFonts.inter(),
          ),
          content: SizedBox(
            height: 120,
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: 'Task Title', hintStyle: GoogleFonts.inter()),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                task.title = controller.text;
                Provider.of<TaskProvider>(context, listen: false)
                    .taskDb
                    .updateTaskdatabase(key, task);
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: GoogleFonts.inter(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //TO DELETE A TASK
  void _showDeleteDialog(BuildContext context, int key, Taskdatabase task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm delete of task?'),
          actions: [
            TextButton(
              onPressed: () {
                Provider.of<TaskProvider>(context, listen: false)
                    .deleteTask(key, task);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
