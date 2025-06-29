import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:pocket_tasks/model/data/taskdatabase.dart';
import 'package:pocket_tasks/model/state_mgt/taskProvider.dart';
import 'package:provider/provider.dart';

class TaskDetailScreen extends StatefulWidget {
  final Taskdatabase task;
  final int index;
  const TaskDetailScreen({super.key, required this.task, required this.index});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final TextEditingController _controller = TextEditingController();

  late DateTime _dueDate;

  @override
  void initState() {
    super.initState();
    _dueDate = widget.task.createdAt ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final task = taskProvider.tasks;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: IconButton(
          icon: Icon(
            Iconsax.home_1,
            size: 23,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.task.title,
          style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(
                'Set Due Date',
                style: GoogleFonts.inter(
                    color: Theme.of(context).colorScheme.primary, fontSize: 15),
              ),
              DueDateButton(
                initialDateTime: _dueDate,
                onDateTimeChanged: (value) {
                  setState(() {
                    _dueDate = value;
                    widget.task.createdAt = value;
                    taskProvider.taskDb
                        .updateTaskdatabase(widget.index, widget.task);
                  });
                },
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Additional Notes',
                style: GoogleFonts.inter(
                    color: Theme.of(context).colorScheme.primary, fontSize: 15),
              ),
              GestureDetector(
                //to add note
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                        title: Text(
                          'Add Notes',
                          style: GoogleFonts.inter(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        content: TextField(
                          controller: _controller,
                          maxLines: 7,
                          decoration: InputDecoration(
                            hintText: 'Enter Note',
                            hintStyle: GoogleFonts.inter(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              if (_controller.text.isNotEmpty) {
                                taskProvider.taskDb
                                    .addNote(widget.index, _controller.text);
                                setState(() {
                                  widget.task.myNotes = _controller.text;
                                  _controller.clear();
                                });
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Add',
                              style: GoogleFonts.inter(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.inter(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },

                //to edit note
                onLongPress: () {
                  if (widget.task.myNotes != null) {
                    _controller.text = widget.task.myNotes!;
                  } else {
                    _controller.clear();
                  }
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                        title: Text(
                          'Edit Action',
                          style: GoogleFonts.inter(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        content: TextField(
                          controller: _controller,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Edit action',
                            hintStyle: GoogleFonts.inter(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: <Widget>[
                          // Save button
                          TextButton(
                            onPressed: () {
                              setState(() {
                                task[widget.index].myNotes = _controller.text;
                                taskProvider.taskDb
                                    .addNote(widget.index, _controller.text);
                                _controller.clear();
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Save',
                              style: GoogleFonts.inter(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                          // Cancel button
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.inter(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                //display the note
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Text(
                        widget.task.myNotes != null &&
                                widget.task.myNotes!.isNotEmpty
                            ? widget.task.myNotes!
                            : 'Enter task',
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color:
                                Theme.of(context).colorScheme.inversePrimary))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//due date button
class DueDateButton extends StatefulWidget {
  final DateTime initialDateTime;
  final ValueChanged<DateTime> onDateTimeChanged;
  const DueDateButton(
      {super.key,
      required this.initialDateTime,
      required this.onDateTimeChanged});

  @override
  State<DueDateButton> createState() => _DueDateButtonState();
}

class _DueDateButtonState extends State<DueDateButton> {
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDateTime;
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
        widget.onDateTimeChanged(_selectedDateTime);
      } else {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            _selectedDateTime.hour,
            _selectedDateTime.minute,
          );
        });
        widget.onDateTimeChanged(_selectedDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMMM d, y').format(_selectedDateTime);
    final formattedTime = DateFormat('h:mm a').format(_selectedDateTime);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _selectDateTime(context),
            child: Center(child: Icon(Iconsax.calendar)),
          ),
          SizedBox(width: 20),
          Center(
            child: Text(
              '$formattedDate  <>  $formattedTime',
              style: GoogleFonts.inter(
                  fontSize: 15, color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}
