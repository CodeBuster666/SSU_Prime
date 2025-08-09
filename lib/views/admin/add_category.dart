import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ssu_prime/models/category.dart';

class AddCategory extends StatefulWidget {
  final Category? category;

  const AddCategory({
    super.key,
    this.category,
  });

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;


  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController(text: widget.category?.name);
    _descriptionController = TextEditingController(text: widget.category?.description);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _savedCategory() async {
    if(!_formKey.currentState!.validate()){
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try{
      if(widget.category != null){
        final updatedCategory = widget.category!.copyWith(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
        );

        await _firestore.collection("categories").doc(widget.category!.id).update(
          updatedCategory.toMap(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Category updated successfully"),
          ),
        );

      } else{
        await _firestore.collection("categories").add(
          Category(
            id: _firestore.collection("categories").doc().id,
            name: _nameController.text.trim(),
            description: _descriptionController.text.trim(),
            createdAt: DateTime.now(),
          ).toMap(),
        );
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Category add successfully"),
          ),
        );
      }
      Navigator.pop(context);
    } catch(e) {
      print("Error: $e");
    }
    finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<bool> _onWillPop() async{
    if(_nameController.text.isNotEmpty || _descriptionController.text.isNotEmpty) {
      return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Discard Changes"),
          content: Text("Are you sure you want to discard changes?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
                },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
                },
              child: Text("Discard",
                style: TextStyle(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .error,
                ),
              ),
            ),
          ],
        ),
      ) ?? false;
    }
    return true;
  }

// Build UI
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.category != null ? "Edit Category" : "Add Category",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category Details",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Create a new category for organizing your quizzes",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 20),
                      fillColor: Colors.white,
                      filled: true,
                      hoverColor: Colors.transparent,
                      labelText: "Category Name",
                      hintText: "Enter Category Name",
                      prefixIcon: Icon(
                        Icons.category_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    validator: (value) =>
                      value!.isEmpty ? "Enter Category Name" : null,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hoverColor: Colors.transparent,
                      labelText: "Description",
                      hintText: "Enter Category Description ",
                      prefixIcon: Icon(
                        Icons.description_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 3,
                    validator: (value) =>
                      value!.isEmpty ? "Enter Description Name" : null,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    width:  double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _savedCategory,
                      child: _isLoading
                          ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                              strokeWidth: 2,
                            ),
                          )
                          : Text(
                            widget.category != null
                                ? "Update Category"
                                : "Add Category",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
