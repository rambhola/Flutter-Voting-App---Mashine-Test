import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:the_statup_idea_evaluator_ai_votting_app/screens/views_model/toggle_controller.dart';
import 'package:get/get.dart';
import 'dart:math';

class SubmissionScreen extends StatefulWidget {
  SubmissionScreen({super.key});

  @override
  State<SubmissionScreen> createState() => _SubmissionScreenState();
}

class _SubmissionScreenState extends State<SubmissionScreen> {
  final ToggleController toggleController = Get.put(ToggleController());

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final taglineController = TextEditingController();
  final descController = TextEditingController();

  //All submmited ideas
  List<Map<String, dynamic>> ideaList = [];

  @override
  void dispose() {
    nameController.dispose();
    taglineController.dispose();
    descController.dispose();
    toggleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Startup Idea \nEvaluator AI Voting App",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 4,
                color: Colors.black26,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF764BA2), Color(0xFF667EEA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFF764BA2), const Color(0xFF667EEA)],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            stops: const [0.0, 0.6],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Container(
                    height: 600,
                    width: 390,

                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.97),

                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 25,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),

                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Submit Your Idea",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 32),

                          // Form fields
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: "Startup Name",
                              prefixIcon: Icon(
                                Icons.business_center,
                                color: Color(0xFF667EEA),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFF667EEA),
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                            ),
                            validator: (value) =>
                                value?.isEmpty ?? true ? 'Name required' : null,
                          ),
                          SizedBox(height: 20),

                          TextFormField(
                            controller: taglineController,
                            decoration: InputDecoration(
                              labelText: "Tagline",
                              prefixIcon: Icon(
                                Icons.format_quote,
                                color: Color(0xFF667EEA),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFF667EEA),
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                            ),
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Tagline required'
                                : null,
                          ),
                          SizedBox(height: 20),

                          TextFormField(
                            controller: descController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: "Description",
                              prefixIcon: Icon(
                                Icons.description,
                                color: Color(0xFF667EEA),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFF667EEA),
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                            ),
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Description required'
                                : null,
                          ),
                          SizedBox(height: 150),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //Form Submission Button with Switch Toggle
                  Container(
                    height: 75,
                    width: 340,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFFFF6B35),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepOrange,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 70),
                              child: InkWell(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final random = Random();
                                    int aiRating = random.nextInt(101);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Container(
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFF764BA2),
                                                Color(0xFF667EEA),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                              SizedBox(width: 16),
                                              Text('AI Rating: $aiRating/100'),
                                            ],
                                          ),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(seconds: 3),
                                      ),
                                    );

                                    // Save idea
                                    final idea = {
                                      'name': nameController.text,
                                      'tagline': taglineController.text,
                                      'desc': descController.text,
                                      'rating': aiRating,
                                      'votes': 0,
                                    };
                                    ideaList.add(idea);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 12),
                                            Text(
                                              "Idea submitted successfully!",
                                            ),
                                          ],
                                        ),
                                        backgroundColor: Color(0xFF00D284),
                                      ),
                                    );

                                    // Clear form
                                    nameController.clear();
                                    taglineController.clear();
                                    descController.clear();
                                  }
                                },
                                child: Text(
                                  "Submit Idea",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Obx(() {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlutterSwitch(
                                  activeColor: Colors.green,
                                  width: 80.0,
                                  height: 37.0,
                                  valueFontSize: 25.0,
                                  toggleSize: 20.0,
                                  value: toggleController.isToggled.value,
                                  onToggle: (value) {
                                    toggleController.isToggled(value);
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
