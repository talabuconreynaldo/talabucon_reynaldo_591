import 'package:flutter/material.dart';
import 'package:modelhandling/screen/login_screen.dart';
import 'package:modelhandling/screen/signup_screen.dart';
import 'package:modelhandling/screen/student_screen_midterm.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: 'https://xkglgjlxjbgklxkjoiqb.supabase.co', anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhrZ2xnamx4amJna2x4a2pvaXFiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzExNTM3OTYsImV4cCI6MjA4NjcyOTc5Nn0.9NEJmKcDmfhoalRk4G2rwGcXfTJH3JS7h6DVtArrZpo'); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginPage(),
    );
  }
}


