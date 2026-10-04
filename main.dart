

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const TukoApp());
}

class TukoApp extends StatelessWidget {
  const TukoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TUKO',
      theme: ThemeData(
        primaryColor: const Color(0xFFFF5A6B),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF5A6B)),
        useMaterial3: true,
      ),
      home: const PairingScreen(),
    );
  }
}

// SCREEN 1: PAIRING - CONSENSUAL
class PairingScreen extends StatelessWidget {
  const PairingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.favorite, size: 80, color: Color(0xFFFF5A6B)),
              const SizedBox(height: 20),
              const Text("TUKO", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              const Text("Stay connected. Build trust"),
              const SizedBox(height: 40),
              TextField(decoration: InputDecoration(labelText: "Your Invite Code", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen())),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF5A6B), minimumSize: const Size(double.infinity, 50)),
                child: const Text("Pair with Partner - Both Must Accept", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              const Text("No secret tracking. Both partners must agree.", style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}

// SCREEN 2: HOME
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String todayQuestion = "What is one thing you appreciated about me this week?";
  String mood = "😊";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TUKO - Today"), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text("DAILY QUESTION", style: TextStyle(letterSpacing: 2, fontSize: 11)),
                  const SizedBox(height: 10),
                  Text(todayQuestion, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  TextField(maxLines: 3, decoration: InputDecoration(hintText: "Type your answer...", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
                  const SizedBox(height: 10),
                  ElevatedButton(onPressed: () {}, child: const Text("Share Answer")),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [const Text("Your Mood"), DropdownButton<String>(value: mood, items: ["😊","😔","😡","🥰","😴"].map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 24)))).toList(), onChanged: (v) => setState(() => mood = v!))])))),
              const SizedBox(width: 10),
              Expanded(child: Card(color: const Color(0xFFFF5A6B), child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [const Icon(Icons.favorite, color: Colors.white), const SizedBox(height: 8), const Text("Thinking of you", style: TextStyle(color: Colors.white)), ElevatedButton(onPressed: () { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sent ❤️ to your partner!"))); }, child: const Text("Send"))])))),
            ],
          ),
        ],
      ),
    );
  }
}

