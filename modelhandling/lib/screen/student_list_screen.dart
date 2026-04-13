import 'package:flutter/material.dart';
import 'package:modelhandling/screen/student_controller.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final StudentController _controller = StudentController();

  // Text controllers for input fields
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _gpaController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  void _addStudent() {
    final id = _idController.text.trim();
    final name = _nameController.text.trim();
    final course = _courseController.text.trim();
    final gpa = double.tryParse(_gpaController.text.trim()) ?? 0.0;

    if (id.isEmpty || name.isEmpty || course.isEmpty) {
      _showMessage('Please fill in all fields.');
      return;
    }

    setState(() {
      _controller.addStudent(id, name, course, gpa);
    });

    _idController.clear();
    _nameController.clear();
    _courseController.clear();
    _gpaController.clear();

    _showMessage('Student added successfully!');
  }

  void _findStudent() {
    final id = _searchController.text.trim();
    final student = _controller.findById(id);

    if (student == null) {
      _showMessage('No student found with ID: $id');
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Student Found'),
        content: Text(
          'Name: ${student.name}\n'
          'Course: ${student.course}\n'
          'GPA: ${student.gpa}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _deleteStudent(String id) {
    setState(() {
      final success = _controller.deleteStudent(id);
      _showMessage(success ? 'Student $id deleted.' : 'Delete failed.');
    });
  }

  @override
  Widget build(BuildContext context) {
    final students = _controller.getAllStudents();

    return Scaffold(
      appBar: AppBar(
        title: Text('Students (${_controller.getCount()})'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add New Student',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _idController,
                      decoration: const InputDecoration(
                        labelText: 'Student ID',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _courseController,
                      decoration: const InputDecoration(
                        labelText: 'Course',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _gpaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'GPA',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _addStudent,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Student'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade800,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search by Student ID',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _findStudent,
                  child: const Text('Find'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: students.isEmpty
                  ? const Center(
                      child: Text('No students yet. Add one above!'),
                    )
                  : ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final s = students[index];

                        return Card(
                          margin:
                              const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  Colors.blue.shade800,
                              child: Text(
                                s.name[0],
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            title: Text(
                              s.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${s.id} | ${s.course} | GPA: ${s.gpa}',
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () =>
                                  _deleteStudent(s.id),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}