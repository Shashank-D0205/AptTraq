import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pennyflow/DIalogBtns/Addexpense.dart';
import 'package:pennyflow/values/values.dart';

class PageHeader extends StatelessWidget {
  final String title;
  const PageHeader({
    Key? key,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 2.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
                fontSize: 24,
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.bold
            ),
          ),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(context: context, builder: (context)=>AddExpenseDialog());
                },
                icon: Icon(Icons.add, color: Colors.white),
                label: Text('Add Expense', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
              SizedBox(width: 30),
              Icon(FontAwesomeIcons.bell),
              SizedBox(width: 30),
              CircleAvatar(
                radius: 20,
                child: Icon(Icons.person),
              ),
              SizedBox(width: 8),
              PopupMenuButton<String>(
                color: Colors.white,
                offset: Offset(40, 40),
                icon: Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  switch (value) {
                    case 'profile':
                      //
                      break;
                    case 'settings':
                    // Navigate to settings page
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'profile',
                    child: Container(
                      width: 200, // Set a fixed width for the menu items
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Icon(Icons.person_outline, color: AppColors.secondaryColor),
                          SizedBox(width: 12),
                          Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'settings',
                    child: Container(
                      width: 200, // Set a fixed width for the menu items
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Icon(Icons.settings_outlined, color: AppColors.secondaryColor),
                          SizedBox(width: 12),
                          Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                // Add shape decoration for the popup menu
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                // Add elevation for shadow
                elevation: 4,
              ),
              SizedBox(width: 30),
            ],
          )
        ],
      ),
    );
  }
}