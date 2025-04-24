import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

enum UrgencyLevel {
  urgentImportant("Urgent Important"),
  notUrgentImportant("Not Urgent Important"),
  notImportantUrgent("Not Important Urgent"),
  notImportantNotUrgent("Not Important Not Urgent");

  final String value;
  const UrgencyLevel(this.value);
}

IconData getIconData(String urgencyLevel) {
  switch (urgencyLevel) {
    case 'Urgent Important':
      return Icons.priority_high;
    case 'Not Urgent Important':
      return Icons.check_circle_outline;
    case 'Not Important Urgent':
      return Icons.access_alarm;
    case 'Not Important Not Urgent':
      return Icons.check_circle;
    default:
      return Icons.error;
  }
}

enum Category {
  office("Office"),
  health("Health"),
  finance("Finance"),
  home("Home"),
  personal("Personal"),
  career("Career"),
  self("Self"),
  leisure("Leisure"),
  fun("Fun");

  final String value;
  const Category(this.value);
}

final Map<String, String> categoryImageMap = {
  'Office': 'assets/Office.jpg',
  'Health': 'assets/Health.jpg',
  'Finance': 'assets/finance.jpg',
  'Home': 'assets/Home.jpg',
  'Personal': 'assets/Personal.jpg',
  'Career': 'assets/Career.jpg',
  'Self Development': 'assets/Self_Development.jpg',
  'Leisure': 'assets/Leisure.jpg',
  'Fun': 'assets/Fun.jpg',
};

var dummyData = [
  ElementTask(
    isPending: true,
    name: 'Finish project proposal',
    urgencyLevel: UrgencyLevel.urgentImportant.value,
    color: Color(0xFFFF0000),
    startTime: DateTime.now().subtract(Duration(hours: 2)),
    absoluteDeadline: DateTime.now().add(Duration(hours: 3)),
    category: Category.office.value,
    desireDeadline: DateTime.now().add(Duration(days: 1)),
  ),

  ElementTask(
    isPending: true,
    name: 'Pay electricity bill',
    urgencyLevel: UrgencyLevel.notImportantUrgent.value,
    category: Category.finance.value,
    color: Color.fromARGB(255, 247, 104, 104),
    startTime: DateTime.now(),
    absoluteDeadline: DateTime.now().add(Duration(hours: 5)),
    desireDeadline: DateTime.now().add(Duration(days: 2)),
  ),

  ElementTask(
    name: 'Water the plants',
    urgencyLevel: UrgencyLevel.urgentImportant.value,
    color: Color(0xFFFF0000),
    isPending: true,
    startTime: DateTime.now(),
    absoluteDeadline: DateTime.now().add(Duration(hours: 2)),
    category: Category.home.value,
    desireDeadline: DateTime.now().add(Duration(days: 1)),
  ),

  ElementTask(
    name: 'Return online order',
    urgencyLevel: UrgencyLevel.urgentImportant.value,
    color: Color(0xFFFF0000),
    isPending: true,
    startTime: DateTime.now().subtract(Duration(hours: 2)),
    absoluteDeadline: DateTime.now().add(Duration(hours: 6)),
    category: Category.personal.value,
    desireDeadline: DateTime.now().add(Duration(days: 1)),
  ),

  ElementTask(
    name: 'Update LinkedIn profile',
    urgencyLevel: UrgencyLevel.notUrgentImportant.value,
    color: Color(0xFFFF0000),
    isPending: true,
    startTime: DateTime.now().subtract(Duration(days: 1)),
    absoluteDeadline: DateTime.now().add(Duration(days: 1)),
    category: Category.career.value,
    desireDeadline: DateTime.now().add(Duration(days: 2)),
  ),

  ElementTask(
    name: 'Organize photo gallery',
    urgencyLevel: UrgencyLevel.notImportantNotUrgent.value,
    color: Color(0xFFFF0000),
    isPending: true,
    startTime: DateTime.now().add(Duration(days: 1)),
    absoluteDeadline: DateTime.now().add(Duration(days: 5)),
    category: Category.self.value,
    desireDeadline: DateTime.now().add(Duration(days: 5)),
  ),
  ElementTask(
    name: 'Try a new game',
    urgencyLevel: UrgencyLevel.notImportantNotUrgent.value,
    color: Color(0xFFFF0000),
    isPending: false,
    startTime: DateTime.now(),
    absoluteDeadline: DateTime.now().add(Duration(days: 3)),
    category: Category.fun.value,
    desireDeadline: DateTime.now().add(Duration(days: 4)),
  ),
];

class ElementTask {
  final String id;
  final bool isPending;
  final String urgencyLevel;
  final String category;
  final String name;
  final DateTime startTime;
  final Color color;
  final DateTime absoluteDeadline;
  final DateTime desireDeadline;

  ElementTask({
    required this.isPending,
    required this.urgencyLevel,
    required this.category,
    required this.name,
    required this.color,
    required this.startTime,
    required this.absoluteDeadline,
    required this.desireDeadline,
  }) : id = uuid.v4(); // Generate a unique ID for each task
}
