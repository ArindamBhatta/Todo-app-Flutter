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

  void _addTaskToList(String title, ElementTask task) {
    Provider.of<TaskProvider>(
      context,
      listen: false,
    ).addTaskToCategory(title, task);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: dummyData.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final categories = taskProvider.categories;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Todo App')),
        backgroundColor: Colors.tealAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ScrollableTabBar(
              menuOptions:
                  categories.map((categoryData) {
                    return categoryData['title'] as String;
                  }).toList(),
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
                          final cardColor = Color(int.parse(task.color));

                          return OpenContainer(
                            closedElevation: 4,
                            openElevation: 0,
                            closedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            transitionType: ContainerTransitionType.fade,
                            closedBuilder: (context, action) {
                              return Stack(
                                children: [
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationZ(3.14159),
                                        child: Image.asset(
                                          categoryImageMap[task.category] ?? '',
                                          fit: BoxFit.cover,
                                          color: Colors.black54,
                                          colorBlendMode: BlendMode.darken,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Icon(
                                      task.isDone
                                          ? Icons.check_circle
                                          : Icons.radio_button_unchecked,
                                      color: cardColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Spacer(),
                                        Text(
                                          task.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          task.category,
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskForm(onAdd: _addTaskToList),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
