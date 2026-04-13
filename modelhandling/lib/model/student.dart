
class Student {

  String id;

  String name;

  String course;

  double gpa;

 

  Student({

    required this.id,

    required this.name,

    required this.course,

    required this.gpa,


  });

 

  @override

  String toString() {

    return 'Student{id: $id, name: $name, course: $course, gpa: $gpa}';

  }

}

 

