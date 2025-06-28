import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ssu_prime/views/admin/manage_quizzes.dart';

import 'manage_categories.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> _fetchStatistics() async {
    final categoriesCount = await _firestore.collection('categories')
        .count()
        .get();
    final quizzesCount = await _firestore.collection('quizzes').count().get();

    // Get the latest quizzes
    final latestQuizzes = await _firestore
        .collection('quizzes')
        .orderBy('createdAt', descending: true)
        .limit(5)
        .get();

    final categories = await _firestore.collection('categories').get();
    final categoryData = await Future.wait(
      categories.docs.map((category) async {
        final quizCount = await _firestore
            .collection('quizzes')
            .where('categoryId', isEqualTo: category.id)
            .count()
            .get();

        return {
          'id': category.data() ['name'] as String,
          'quizzes': quizCount.count,
        };
      },
      ),
    );

    return {
      'totalCategories': categoriesCount.count,
      'totalQuizzes': quizzesCount.count,
      'latestQuizzes': latestQuizzes.docs,
      'categoryData': categoryData,
    };
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildStatCard(String title, String value, IconData icon,
      Color color,) {
    return Card(
      child: Padding(padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 25,
              ),
            ),

            SizedBox(height: 16),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary,
              ),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Theme
                    .of(context)
                    .textTheme
                    .titleLarge
                    ?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget where you can manipulate the Card
  Widget _buildDashboardCard(BuildContext context, String title, IconData icon,
      VoidCallback onTap,) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Theme
                    .of(context)
                    .colorScheme
                    .primary, size: 32),
              ),
              SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme
                      .of(context)
                      .textTheme
                      .titleMedium
                      ?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .surface,
        title: Text(
          'Admin Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(future: _fetchStatistics(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('An error occured'),
              );
            }
            final Map<String, dynamic> stats = snapshot.data!;
            final List<dynamic> categoryData = stats['categoryData'];
            final List<QueryDocumentSnapshot> latestQuizzes =
            stats['latestQuizzes'];

            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Admin",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                      ),
                    ),

                    SizedBox(height: 8),
                    Text(
                      "SSU-Prime Overview",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.color,
                      ),
                    ),
                    SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            'Total Cetegories',
                            stats['totalCategories'].toString(),
                            Icons.category_rounded,
                            Theme
                                .of(context)
                                .colorScheme
                                .primary,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildStatCard(
                            'Total Quizzes',
                            stats['totalQuizzes'].toString(),
                            Icons.quiz_rounded,
                            Theme
                                .of(context)
                                .colorScheme
                                .secondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    // Card for the Category Statistics
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.pie_chart_rounded,
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .primary,
                                  size: 24,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Category Statistics',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Theme
                                          .of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.color
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: categoryData.length,
                              itemBuilder: (context, index) {
                                final category = categoryData[index];
                                final totalQuizzes = categoryData.fold<int>(
                                  0,
                                      (sum, item) =>
                                  sum + (item['count'] as int),
                                );
                                final percentage = totalQuizzes > 0
                                    ? (category['count'] as int) /
                                    totalQuizzes + 100 : 0.0;

                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              category['name'] as String,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.color,
                                              ),
                                            ),

                                            SizedBox(height: 5),
                                            Text(
                                              "${category['count']} ${(category['count'] as int) ==
                                                  1 ? 'quiz' : 'quizzes'}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.color,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                              20),
                                        ),
                                        child: Text(
                                          '${percentage.toStringAsFixed(1)}%',
                                          style: TextStyle(
                                            color: Theme
                                                .of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.w500,
                                          ),
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
                    ),
                    SizedBox(height: 24),

                    // Card for the Recent Activity
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.history_rounded,
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .primary,
                                  size: 24,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Recent Activity',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Theme
                                          .of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.color
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: latestQuizzes.length,
                              itemBuilder: (context, index) {
                                final quiz = latestQuizzes[index].data()
                                as Map<String, dynamic>;
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                              8),
                                        ),
                                        child: Icon(
                                          Icons.quiz_rounded,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .primary,
                                          size: 20,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            quiz['title'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme
                                                  .of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Created on ${_formatDate(
                                                quiz['createdAt'].toDate())}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.color,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
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
                    ),
                    SizedBox(height: 24),

                    // Card for the Quiz Action
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.speed_rounded,
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .primary,
                                  size: 24,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Quiz Actions',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Theme
                                          .of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.color
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            GridView.count(crossAxisCount: 2,
                              shrinkWrap: true,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.9,
                              crossAxisSpacing: 16,
                              children: [
                                _buildDashboardCard(
                                  context,
                                  'Quizzes',
                                  Icons.quiz_rounded,
                                      () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ManageQuizzes(),
                                      ),
                                    );
                                  },
                                ),
                                _buildDashboardCard(
                                  context,
                                  'Categories',
                                  Icons.category_rounded,
                                      () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ManageCategories(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
      ),
    );
  }
}
 