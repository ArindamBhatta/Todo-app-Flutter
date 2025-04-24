import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/scrollable_tab_bar.dart';
import 'package:todo/data/todo.dart';
import 'package:todo/home/add_task_form.dart';
import 'package:todo/home/details_page.dart';
import 'package:animations/animations.dart';
import 'package:todo/logic/todo_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: dummyData.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Todo App')),
        backgroundColor: Colors.tealAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Column(
          children: [
            ScrollableTabBar(
              menuOptions:
                  UrgencyLevel.values.map((label) => label.value).toList(),
              tabController: _tabController,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children:
                    categories.map((categoryData) {
                      final tasks = categoryData['tasks'] as List<ElementTask>;
                      return GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.85,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          final cardColor = Color();

                          return OpenContainer(
                            closedElevation: 4,
                            openElevation: 0,
                            closedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            transitionType: ContainerTransitionType.fade,
                            closedBuilder: (context, action) {
                              return Card(
                                margin: EdgeInsets.zero,
                                elevation: 1,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                              ),
                                              child: Image.asset(
                                                categoryImageMap[task
                                                        .category] ??
                                                    '',
                                                fit: BoxFit.cover,

                                                colorBlendMode:
                                                    BlendMode.darken,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child: Icon(
                                              task.isPending
                                                  ? Icons.pending_actions
                                                  : Icons.check_circle,
                                              color: cardColor,
                                            ),
                                          ),
                                          Positioned(
                                            top: 10,
                                            left: 8,
                                            child: Text(
                                              task.category,
                                              style: TextStyle(
                                                color: cardColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: cardColor.withAlpha(30),
                                      height: 50,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          task.name,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            openBuilder: (context, action) {
                              return DetailsPage(
                                categoryTitle: categoryData['title'],
                                taskIndex: index,
                                task: task,
                              );
                            },
                          );
                        },
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: OpenContainer(
        transitionDuration: Duration(milliseconds: 900),
        transitionType: _transitionType,
        openBuilder: (context, action) {
          return AddTaskForm(onAdd: _addTaskToList);
        },
        closedElevation: 6,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        closedColor: Colors.teal,
        openColor: Colors.white,

        closedBuilder: (context, action) {
          return FloatingActionButton(
            backgroundColor: Colors.teal,
            onPressed: null,
            child: const Icon(Icons.add, size: 30, color: Colors.white),
          );
        },
      ),
    );
  }
}
