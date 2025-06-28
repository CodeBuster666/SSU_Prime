import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ssu_prime/models/category.dart';

class ManageCategories extends StatefulWidget {
  const ManageCategories({super.key});

  @override
  State<ManageCategories> createState() => _ManageCategoriesState();
}

class _ManageCategoriesState extends State<ManageCategories> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Manage Categories",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){

              /*
              Navigator.push(context,
                MaterialPageRoute(builder: (builder) =>
                    AddCategoryScreen(),),
              );
              */

            },
            icon: Icon(
              Icons.add_circle_outline,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("categories").orderBy('name').snapshots(),
        builder:
            (context, snapshot) {
            if(snapshot.hasError) {
              return Center(
                child: Text("Error"),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            }

            final categories = snapshot.data!.docs
                .map((doc)=> Category.fromMap(doc.id,doc.data() as Map<String, dynamic>))
                .toList();

              if(categories.isEmpty){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.category_outlined,
                        size: 64,
                        color: Theme.of(context).textTheme.titleMedium?.color,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "No Categories Found",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: (){
                            /*
                            Navigator.push(context,
                              MaterialPageRoute(builder: builder) =>
                            );
                            
                             */
                        },
                        child: Text("Add Category"),
                      ),
                    ],
                  ),
                );
              }
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final Category category = categories[index];
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
                        Icons.category_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    title: Text(
                      category.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      category.description,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder:
                      (context) =>[
                        PopupMenuItem(
                          value: "edit",
                          child: ListTile(
                            leading: Icon(
                              Icons.edit,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text("Edit"),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        PopupMenuItem(
                          value: "delete",
                          child: ListTile(
                            leading: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            title: Text("Delete"),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        _handleCategoryAction(context, value, category);
                      },
                    ),
                    onTap: (){
                      /*
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      ));

                       */
                    },
                  ),
                );
              },
            );
        },
      ),
    );
  }
  Future<void> _handleCategoryAction(BuildContext context, String action, Category category) async {
    if (action == "edit") {
      //Navigator.push(context, MaterialPageRoute(builder: (context) => QuizList(categoryId: category))
    }else if (
    action == "delete") {
      await _firestore.collection("categories").doc(category.id).delete();
    }
  }
}
