import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'venues_page.dart';
import 'budget_page.dart';
import 'guest_page.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.database; // init database
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wedding Planner',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      home: SplashScreen(toggleTheme: toggleTheme),
    );
  }
}

class MainNavigation extends StatefulWidget {
  final VoidCallback toggleTheme;

  MainNavigation({required this.toggleTheme});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  late final pages = [
    HomePage(toggleTheme: widget.toggleTheme), // checklist page
    VenuesPage(),   // venues page
    BudgetPage(),   // budget calculator
    GuestPage(),    // guest list
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.checklist), label: "Checklist"),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_city), label: "Venues"),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: "Budget"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Guests"),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;

  HomePage({required this.toggleTheme});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  // fetch tasks
  void loadTasks() async {
    final data = await DBHelper.getTasks();
    setState(() => tasks = data);
  }

  // add dummy task
  void addTask() async {
    await DBHelper.insertTask({
      'title': 'Book Venue',
      'notes': 'Confirm by next week',
      'done': 0,
    });
    loadTasks();
  }

  // toggle task done
  void toggleTask(int id, String title, String notes, bool done) async {
    await DBHelper.updateTask(
      id,
      {
        'title': title,
        'notes': notes,
        'done': done ? 1 : 0,
      },
    );
    loadTasks();
  }

  // delete task
  void deleteTask(int id) async {
    await DBHelper.deleteTask(id);
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wedding Checklist'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: tasks.isEmpty
          ? Center(child: Text('No tasks yet, add some!'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (ctx, i) {
                final task = tasks[i];
                return ListTile(
                  title: Text(task['title']),
                  subtitle: Text(task['notes'] ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: task['done'] == 1,
                        onChanged: (val) {
                          toggleTask(
                            task['id'],
                            task['title'],
                            task['notes'] ?? '',
                            val!,
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteTask(task['id']),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: Icon(Icons.add),
      ),
    );
  }
}