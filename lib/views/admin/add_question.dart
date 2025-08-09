import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ssu_prime/models/category.dart';
import 'package:ssu_prime/models/question.dart';
import 'package:ssu_prime/models/quiz.dart';

class AddQuestion extends StatefulWidget {
  final String? categoryId;
  final String? categoryName;

  const AddQuestion({
    super.key,
    this.categoryId,
    this.categoryName,
  });

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class QuestionFromItem{
  final TextEditingController questionController;
  final List<TextEditingController> optionsControllers;
  int correctOptionIndex;

  QuestionFromItem({
    required this.questionController,
    required this.optionsControllers,
    required this.correctOptionIndex,
  });

  void dispose(){
    questionController.dispose();
    optionsControllers.forEach((element){
      element.dispose();
    });
  }
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _timeLimitController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  String? _selectedCategoryId;
  List<QuestionFromItem> _questionItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedCategoryId = widget.categoryId;
    _addQuestion();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _timeLimitController.dispose();
    for (var item in _questionItems) {
      item.dispose();
    }
    super.dispose();
  }

  // Logic on Adding a Question
  void _addQuestion(){
    setState(() {
      _questionItems.add(
        QuestionFromItem(
          questionController: TextEditingController(),
          optionsControllers: List.generate(
            4,
            (_)=> TextEditingController(),
          ),
          correctOptionIndex: 0,
        ),
      );
    });
  }

  // Logic on Removing a Question
  void _removeQuestion(int index) {
    setState(() {
      _questionItems[index].dispose();
      _questionItems.removeAt(index);
    });
  }

  // Logic on Saving a Question
  Future<void> _saveQuiz() async{
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if(_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a category"),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try{
      final questions = _questionItems.map(
        (item) => Question(
          text: item.questionController.text.trim(),
          options: item.optionsControllers.map((e) => e.text.trim()).toList(),
          correctOptionIndex: item.correctOptionIndex,
        ),
      ).toList();
      await _firestore.collection("quizzes").doc().set(
        Quiz(
          id: _firestore.collection("quizzes").doc().id,
          title: _titleController.text.trim(),
          categoryId: _selectedCategoryId!,
          timeLimit: int.parse(_timeLimitController.text),
          questions: questions,
          createdAt: DateTime.now(),
        ).toMap(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Quiz added succesfully",
            style: TextStyle(
              color: Colors.white
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
        ),
      );
      Navigator.pop(context);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Failed to add Quiz",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
    finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.categoryName != null
            ? "Add ${widget.categoryName} Quiz"
            : "Add Quiz",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _isLoading ? null : _saveQuiz,
            icon: Icon(
              Icons.save,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Quiz Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),

                SizedBox(height: 20),

                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hoverColor: Colors.transparent,
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                    labelText: "Quiz Title",
                    hintText: "Enter quiz title",
                    prefixIcon: Icon(Icons.title,
                    color: Theme.of (context).colorScheme.primary),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter quiz title";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                if(widget.categoryId == null)
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('categories').orderBy('name').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error");
                    }
                    if (!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      );
                    }
                    final categories = snapshot.data!.docs
                        .map((doc) => Category.fromMap(
                          doc.id,
                          doc.data() as Map<String, dynamic>))
                        .toList();

                    return DropdownButtonFormField<String>(
                      value: _selectedCategoryId,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hoverColor: Colors.transparent,
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        labelText: "Category",
                        hintText: "Selected Category",
                        prefixIcon: Icon(
                          Icons.category,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      items: categories.map(
                        (category) => DropdownMenuItem(
                          value: category.id,
                          child: Text(category.name),
                          ),
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategoryId = value;
                        });

                      },
                      validator: (value){
                        value == null ? "Please select a category" : null;
                      },
                    );
                  },
                ),

                SizedBox(height: 16),

                // Time Limit Form Field
                TextFormField(
                  controller: _timeLimitController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hoverColor: Colors.transparent,
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                    labelText: "Time Limit (in minutes)",
                    hintText: "Enter time limit",
                    prefixIcon: Icon(
                      Icons.timer,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter time limit";
                    }
                    final number = int.tryParse(value);
                    if (number == null || number <= 0){
                      return "Please enter a valid time limit";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.titleMedium?.color,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _addQuestion,
                          label: Text(
                            "Add Question",
                            style: TextStyle(
                                fontSize: 16,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            overlayColor: Colors.transparent,
                            minimumSize: Size(10, 47 ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ... _questionItems.asMap().entries.map((entry){
                      final index = entry.key;
                      final QuestionFromItem question = entry.value;

                      return Card(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Padding(padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Question  ${index + 1}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  if(_questionItems.length > 1)
                                    IconButton(
                                      onPressed: (){
                                        _removeQuestion(index);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Theme.of(context).colorScheme.error,
                                      ),
                                    ),
                                ],
                              ),

                              SizedBox(height: 16),

                              TextFormField(
                                controller: question.questionController,
                                decoration: InputDecoration(
                                  filled: true,
                                  hoverColor: Colors.transparent,
                                  labelText: "Question Title",
                                  hintText: "Enter question",
                                  prefixIcon: Icon(
                                    Icons.question_answer,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter Time Limit";
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height: 16),

                              ...question.optionsControllers.asMap().entries.map(
                                (entry) {
                                  final optionIndex = entry.key;
                                  final controller = entry.value;

                                  return Padding(padding: EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      children: [
                                        Radio<int>(
                                          activeColor: Theme.of(context).colorScheme.primary,
                                          value: optionIndex,
                                          groupValue: question.correctOptionIndex,
                                          onChanged: (value) {
                                            setState(() {
                                              question.correctOptionIndex = value!;
                                            });
                                          },
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                          controller: controller,
                                            decoration: InputDecoration(
                                              filled: true,
                                              hoverColor: Colors.transparent,
                                              labelText: "Option ${optionIndex + 1}",
                                              hintText: "Enter option",
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                               return "Please enter option";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    SizedBox(height: 32),

                    Center(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _saveQuiz,
                          child: _isLoading ?
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                              ),
                              strokeWidth: 2,
                            ),
                          ): Text(
                            "Save Quiz",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
