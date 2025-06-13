import 'package:flutter/material.dart';
import 'package:ssu_prime/components/drawer.dart';

/*
  Schedule

  - Date (Month, Week, Day)
  - Upcoming Events (Add, Delete)

*/

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          MyDrawer(),

          Expanded(
            child: Column(
              children: [

                buildContainer(context),

                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [

                      const SizedBox(width: 15),

                      // Drop down
                      PopupMenuButton<String>(
                        itemBuilder: (context) => [
                          'January', 'February', 'March', 'April',
                          'May', 'June', 'July', 'August',
                          'September', 'October', 'November', 'December'
                        ].map((month) {
                          return PopupMenuItem(
                            value: month,
                            child: Text(month),
                          );
                        }).toList(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Month',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Container buildContainer(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Schedule",
            style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge?.color,
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
          ),

          Container(
            height: 50,
            width: 226,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end
              ,
              children: [
                Icon(
                  Icons.person,
                  size: 25,
                  color: Theme.of(context).iconTheme.color,
                ),
                SizedBox(width: 15),
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
