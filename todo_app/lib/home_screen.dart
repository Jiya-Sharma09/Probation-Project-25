import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// HomeScreen is now a StatefulWidget because we need to manage the state of the text input field.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Get the current logged-in user.
  final User? currentUser = FirebaseAuth.instance.currentUser;
  
  // Controller for the text field used to add new todos.
  final TextEditingController _todoController = TextEditingController();

  // Reference to the user's specific todo collection in Firestore.
  // The path is 'users/{userId}/todos', which matches your security rules.
  late CollectionReference _todoCollection;

  @override
  void initState() {
    super.initState();
    // This check is important. If for some reason there's no user, we shouldn't proceed.
    if (currentUser != null) {
      _todoCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('todos');
    }
  }

  // --- CRUD Operations ---

  // CREATE a new todo item
  Future<void> _addTodo() async {
    final String task = _todoController.text.trim();
    if (task.isNotEmpty) {
      await _todoCollection.add({
        'task': task,
        'isDone': false,
        'createdAt': Timestamp.now(), // Helps in sorting todos by creation time
      });
      _todoController.clear(); // Clear the text field after adding
    }
  }

  // UPDATE a todo item's status (isDone)
  Future<void> _updateTodoStatus(String todoId, bool isDone) async {
    await _todoCollection.doc(todoId).update({'isDone': isDone});
  }

  // DELETE a todo item
  Future<void> _deleteTodo(String todoId) async {
    await _todoCollection.doc(todoId).delete();
  }

  // --- Logout Functionality ---
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If there is no logged-in user, show a simple error message.
    if (currentUser == null) {
      return const Scaffold(body: Center(child: Text("User not logged in.")));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${currentUser!.email?.split('@')[0]}\'s To-Do List' ?? 'My To-Do List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        children: [
          // --- UI for Adding Todos ---
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                      labelText: 'Add a new to-do...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add, size: 30),
                  onPressed: _addTodo,
                ),
              ],
            ),
          ),
          
          // --- UI for Displaying Todos (READ) ---
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              // Listen to the stream of our todo collection, ordered by creation time.
              stream: _todoCollection.orderBy('createdAt', descending: true).snapshots(),
              builder: (context, snapshot) {
                // 1. If we are waiting for data, show a loading spinner.
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                // 2. If there's an error, display it.
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                // 3. If there is no data or no todos, show a message.
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No to-dos yet! Add one above.'));
                }

                // 4. If we have data, display it in a list.
                final todos = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    final todoData = todo.data() as Map<String, dynamic>;
                    
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: ListTile(
                        // Checkbox to update the todo's status
                        leading: Checkbox(
                          value: todoData['isDone'],
                          onChanged: (bool? value) {
                            _updateTodoStatus(todo.id, value!);
                          },
                        ),
                        // The task text. We strike through it if it's done.
                        title: Text(
                          todoData['task'],
                          style: TextStyle(
                            decoration: todoData['isDone']
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        // Delete button
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteTodo(todo.id),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

