import 'package:flutter/material.dart';

class ReviewModulesPage extends StatelessWidget {
  const ReviewModulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar Navigation
          Container(
            width: 250,
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SSU Prime',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 30),
                _buildNavItem('Dashboard', Icons.dashboard),
                _buildNavItem('Review Modules', Icons.menu_book, isActive: true),
                _buildNavItem('Mock Tests', Icons.quiz),
                _buildNavItem('Leaderboard', Icons.leaderboard),
                _buildNavItem('Scheduler', Icons.calendar_today),
                _buildNavItem('Admin Tools', Icons.settings),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  const Text(
                    'Review Modules',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Search Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search modules...',
                        border: InputBorder.none,
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Module Cards
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildModuleCard(
                            'Educational Psychology',
                            'Understanding learning theories and cognitive development',
                            75,
                          ),
                          _buildModuleCard(
                            'Teaching Methods',
                            'Modern approaches to effective teaching strategies',
                            45,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'All Subjects',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Row(
                                  children: [
                                    Text('Sort by: Latest'),
                                    Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildModuleCard(
                            'Child Development',
                            'Physical and cognitive development stages',
                            0,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Pagination
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Previous'),
                          SizedBox(width: 20),
                          Text('1', style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(width: 10),
                          Text('2'),
                          SizedBox(width: 10),
                          Text('3'),
                          SizedBox(width: 20),
                          Text('Next'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}