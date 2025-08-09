import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/category.dart';
import '../../models/question.dart';
import '../../models/quiz.dart';

class EditQuiz extends StatefulWidget {
  final Quiz quiz;
  final String? categoryId;


  const EditQuiz({
    super.key,
    required this.quiz,
    this.categoryId,
  });

  @override
  State<EditQuiz> createState() => _EditQuizState();
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

class _EditQuizState extends State<EditQuiz> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _timeLimitController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  String? _selectedCategoryId;
  late List<QuestionFromItem> _questionItems;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
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

  void _initData() {
    _titleController = TextEditingController(text: widget.quiz.title);
    _timeLimitController =
        TextEditingController(text: widget.quiz.timeLimit.toString());

    _questionItems = widget.quiz.questions.map((question) {
      return QuestionFromItem(
        questionController: TextEditingController(text: question.text),
        optionsControllers: question.options
            .map((option) => TextEditingController(text: option))
            .toList(),
        correctOptionIndex: question.correctOptionIndex,
      );
    }).toList();
    _selectedCategoryId = widget.quiz.categoryId;
  }

  void _addQuestion() {
    setState(() {
      _questionItems.add(
        QuestionFromItem(
          questionController: TextEditingController(),
          optionsControllers: List.generate(4, (e) => TextEditingController()),
          correctOptionIndex: 0,
        ),
      );
    });
  }

  void _removeQuestion(int index) {
    if (_questionItems.length > 1) {
      setState(() {
        _questionItems[index].dispose();
        _questionItems.removeAt(index);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Quiz must have at least one question"),
        ),
      );
    }
  }

  // Update Quiz Logic
  Future<void> _updateQuiz() async{
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a category")),
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

      final _updateQuiz = widget.quiz.copyWith(
        title: _titleController.text.trim(),
        timeLimit: int.parse(_timeLimitController.text),
        questions: questions,
        categoryId: _selectedCategoryId,
      );

      await _firestore.collection("quizzes").doc(widget.quiz.id).update(
        _updateQuiz.toMap(isUpdate : true),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Quiz updated succesfully",
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
            "Failed to update Quiz: $e",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Quiz",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: _isLoading ? null : _updateQuiz,
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
            Text(
              "Quiz Details",
              style:  TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
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

            // Display current category name
            if(widget.quiz.categoryId != null)
              FutureBuilder<DocumentSnapshot>(
                  future: _firestore.collection('categories').doc(widget.quiz.categoryId).get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(padding: EdgeInsets.all(8.0),
                      );
                    }
                    if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
                      return const Text("Category not found");
                    }
                    final categoryData =
                    snapshot.data!.data() as Map<String, dynamic>;
                    final category = Category.fromMap(snapshot.data!.id, categoryData);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Current Category: ${category.name}"),
                    );
                  }
              ),

            SizedBox(height: 10),

            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('categories').orderBy('name').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Error");
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty){
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

                // Ensure _selectedCategoryId matches a category.id, or set to null if no match
                if (_selectedCategoryId != null && !categories.any((cat) => cat.id == _selectedCategoryId)) {
                  _selectedCategoryId = categories.first.id; // Default to first category if no match
                }

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
                      onPressed: _isLoading ? null : _updateQuiz,
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
                        "Update Quiz",
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
      ),
    );
  }
}