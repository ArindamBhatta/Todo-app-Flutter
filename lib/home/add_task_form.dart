import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo/home/home_screen.dart';

class AddTaskForm extends StatefulWidget {
  final Function(String title, ElementTask newTask) onAdd;

  const AddTaskForm({required this.onAdd, Key? key}) : super(key: key);

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();

  String title = 'Urgent Important';
  String name = '';
  String category = 'Office';

  DateTime startTime = DateTime.now();
  DateTime deadline = DateTime.now().add(Duration(hours: 1));
  DateTime targetDate = DateTime.now().add(Duration(days: 1));
  DateTime expectedSubmitDate = DateTime.now().add(Duration(days: 2));

  Color currentColor = Colors.purple;
  Color pickerColor = Colors.purple;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Future<void> pickDateTime({
    required DateTime initialDate,
    required Function(DateTime) onPicked,
  }) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if (time != null) {
        onPicked(
          DateTime(date.year, date.month, date.day, time.hour, time.minute),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: title,
                items:
                    [
                          'Urgent Important',
                          'Not Important Urgent',
                          'Important Not Urgent',
                          'Not Important Not Urgent',
                        ]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (val) => setState(() => title = val!),
                decoration: const InputDecoration(labelText: "Quadrant Title"),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Task Name'),
                onChanged: (val) => name = val,
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
              ),
              DropdownButtonFormField<String>(
                value: category,
                items:
                    [
                          'Office',
                          'Health',
                          'Finance',
                          'Home',
                          'Personal',
                          'Career',
                          'Self Development',
                          'Leisure',
                          'Fun',
                        ]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (val) => setState(() => category = val!),
                decoration: const InputDecoration(labelText: "Category"),
              ),
              const SizedBox(height: 16),
              Text("Color Preview:"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: currentColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      pickerColor = currentColor;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Pick a color!'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: pickerColor,
                                onColorChanged: changeColor,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() => currentColor = pickerColor);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Got it'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Choose Task Color'),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              _buildDateTimePicker(
                label: "Start Time",
                value: startTime,
                onPressed:
                    () => pickDateTime(
                      initialDate: startTime,
                      onPicked: (dt) => setState(() => startTime = dt),
                    ),
              ),
              _buildDateTimePicker(
                label: "Deadline",
                value: deadline,
                onPressed:
                    () => pickDateTime(
                      initialDate: deadline,
                      onPicked: (dt) => setState(() => deadline = dt),
                    ),
              ),
              _buildDateTimePicker(
                label: "Target Date",
                value: targetDate,
                onPressed:
                    () => pickDateTime(
                      initialDate: targetDate,
                      onPicked: (dt) => setState(() => targetDate = dt),
                    ),
              ),
              _buildDateTimePicker(
                label: "Expected Submit Date",
                value: expectedSubmitDate,
                onPressed:
                    () => pickDateTime(
                      initialDate: expectedSubmitDate,
                      onPicked: (dt) => setState(() => expectedSubmitDate = dt),
                    ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text("Add Task"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onAdd(
                      title,
                      ElementTask(
                        name: name,
                        color: currentColor.value.toRadixString(16),
                        isDone: false,
                        startTime: startTime,
                        deadline: deadline,
                        category: category,
                        targetDate: targetDate,
                        expectedSubmitDate: expectedSubmitDate,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker({
    required String label,
    required DateTime value,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(label),
        subtitle: Text(value.toString()),
        trailing: const Icon(Icons.calendar_today),
        onTap: onPressed,
      ),
    );
  }
}
