import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ssu_prime/views/admin/add_question.dart';
import 'package:ssu_prime/views/admin/edit_quiz.dart';
import '../../models/category.dart';
import '../../models/quiz.dart';

class ManageQuizzes extends StatefulWidget {
  final String? categoryId;
  final String? categoryName;

   const ManageQuizzes({
    super.key,
     this. categoryId,
     this.categoryName,
  });

  @override
  State<ManageQuizzes> createState() => _ManageQuizzesState();
}

class _ManageQuizzesState extends State<ManageQuizzes> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = "";
  String? _selectedCategoryId;
  List<Category> _categories = [];
  Category? _initialCategory;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async{
    try{
      final querySnapshot = await _firestore.collection("categories").get();
      final categories = querySnapshot.docs
          .map((doc) =>
            Category.fromMap(doc.id, doc.data()))
          .toList();

          setState(() {
            _categories = categories;
            if(widget.categoryId != null) {
              _initialCategory = _categories.firstWhere((category) => category.id == widget.categoryId,
                orElse: () => Category(
                  id: widget.categoryId!,
                  name: "Unknown",
                  description: '',
                ),
              );

              _selectedCategoryId = _initialCategory!.id;
            }
          });
    } catch(e){
      print("Error Fetching Categories: $e");
    }
  }

  Stream<QuerySnapshot> _getQuizStream(){
    Query query = _firestore.collection("quizzes");

    String? filterCategoryId = _selectedCategoryId ?? widget.categoryId;

    if(filterCategoryId != null) {
      query = query.where("categoryId", isEqualTo: filterCategoryId);
    }
    return query.snapshots();
  }

  // Header
  Widget _buildTitle() {
    String? categoryId = _selectedCategoryId ?? widget.categoryId;
    if(categoryId == null){
      return Text("All Quizzes",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );
    }
    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore.collection('categories').doc(categoryId).snapshots(),
      builder: (context, snapshot){
        if (!snapshot.hasData){
          return Text(
            "Loading...",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          );
        }
        final category = Category.fromMap(
          categoryId,
          snapshot.data!.data() as Map<String, dynamic>,
        );
        return Text(
          category.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _buildTitle(),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                  AddQuestion(
                    categoryId: widget.categoryId,
                    categoryName: widget.categoryName,
                  ),
                ),
              );
            },
            icon: Icon(Icons.add_circle_outline,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(12),

            // Search Bar
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hoverColor: Colors.transparent,
                hintText: "Search Quizzes",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),

          // Drop down Button
          Padding(
            padding: EdgeInsets.all(12),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hoverColor: Colors.transparent, // Ensure input field hover is transparent
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: "Category",
              ),
              value: _selectedCategoryId,
              items: [
                DropdownMenuItem(
                  child: Text("All Categories"),
                  value: null,
                ),
                if (_initialCategory != null &&
                    _categories.every((c) => c.id != _initialCategory!.id))
                  DropdownMenuItem(
                    child: Text(_initialCategory!.name),
                    value: _initialCategory!.id,
                  ),
                ..._categories.map((category) => DropdownMenuItem(
                  child: Text(category.name),
                  value: category.id,
                )),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCategoryId = value;
                });
              },
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _getQuizStream(),
              builder: (context, snapshot){
                if(snapshot.hasError){
                  return Center(
                    child: Text("Error"),
                  );
                }

                // Loading
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }

                final quizzes = snapshot.data!.docs
                .map((doc) => Quiz.fromMap(doc.id, doc.data() as Map<String, dynamic>))
                .where((quiz) => _searchQuery.isEmpty || quiz.title.toLowerCase().contains(_searchQuery))
                .toList();

                if(quizzes.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.quiz_outlined,
                          size: 64,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "No quizzes yet",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed:() {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                  AddQuestion(
                                    categoryId: widget.categoryId,
                                    categoryName: widget.categoryName,
                                  ),
                              ),
                            );
                          },
                          child: Text("Add Quiz"),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: quizzes.length,
                  itemBuilder: (context, index) {
                    final Quiz quiz = quizzes [index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.quiz_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        title: Text(quiz.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.question_answer_outlined,
                                  size: 16,
                                ),
                                SizedBox(width:4),
                                Text("${quiz.questions.length} Questions"),
                                SizedBox(width: 16),
                                Icon(
                                  Icons.timer_outlined,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text("${quiz.timeLimit} mins"),
                              ],
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: "edit",
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(
                                  Icons.edit_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: Text("Edit"),
                              ),
                            ),
                            PopupMenuItem(
                              value: "delete",
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(
                                  Icons.delete,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                title: Text("Delete"),
                              ),
                            ),
                          ],
                          onSelected: (value) => _handleQuizAction(context, value, quiz),
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

  Future<void> _handleQuizAction (
      BuildContext context, String value, Quiz quiz) async {
    if (value == "edit") {
      Navigator.push(context,
        MaterialPageRoute(builder: (context) =>
          EditQuiz(quiz: quiz),
        ),
      );
    } else if ( value == "delete") {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Delete Quiz"),
          content: Text("Are you sure you want to delete this quiz?"),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context, false);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context, true);
              },
              child: Text(
                  "Delete",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                )
              ),
            ),
          ],
        ),
      );

      if (confirm == true) {
        await _firestore.collection("quizzes").doc(quiz.id).delete();
       }
    }
  }
}
