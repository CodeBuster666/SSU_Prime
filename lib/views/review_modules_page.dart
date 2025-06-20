import 'package:flutter/material.dart';
import 'package:ssu_prime/components/card.dart';
import 'package:ssu_prime/components/drawer.dart';

/*

  Review Modules

  - This is where the students read their modules.

  -------------------------------------------------------------
  Contains
  - Search Bar
  - Categories ( e.g. 'All Subjects')
  - Sort By ( e.g. 'Latest')

*/


class ReviewModulesPage extends StatelessWidget {
  const ReviewModulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Row(
        children: [
          MyDrawer(),

          // Main Content
          Expanded(
            flex: 5,
            child: Column(
              children: [

                // Header
                _buildHeader(context),

                // Search Bar
                _buildSearchBar(context),

                // Cards Content
                _buildCards(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildCards(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: MyCard(
                  title: 'Educational Psychology',
                  description: 'Understanding learning theories and cognitive development',
                  label: 'Progress',
                  progress: 75,
                  onPressed: () {},
                ),
              ),

              const SizedBox(width: 20),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: MyCard(
                  title: 'Teaching Methods',
                  description: 'Modern approaches to effective teaching strategies',
                  label: 'Progress',
                  progress: 45,
                  onPressed: () {},
                ),
              ),

              const SizedBox(width: 20),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: MyCard(
                  title: 'Child Development',
                  description: 'Physical and cognitive development stages',
                  label: 'Progress',
                  progress: 0,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Search Field
          Expanded(
            flex: 3,
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 9),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search modules...",
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),

          const Spacer(flex: 2),

          // Subject Dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('All Subjects'),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),

          const SizedBox(width: 15),

          // Sort Dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Sort by: Latest'),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Review Modules",
            style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge?.color,
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
          ),

          Container(
            height: 50,
            width: 226,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.person,
                  size: 25,
                  color: Theme.of(context).iconTheme.color,
                ),
                const SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Maria Santos",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Student",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}