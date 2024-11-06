import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pennyflow/DIalogBtns/Addexpense.dart';
import 'package:pennyflow/values/values.dart';
import 'Auth/LogIn.dart';

class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;
  final Function(int) onIndexChanged;

  const MobileAppBar({
    Key? key,
    required this.currentIndex,
    required this.onIndexChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(FontAwesomeIcons.bars, color: Colors.black, size: 20),
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (context, animation, secondaryAnimation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(-1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: Material(
                      child: Container(
                        width: 280,
                        color: Colors.white,
                        child: SafeArea(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'AptTraq',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(FontAwesomeIcons.bell, size: 20),
                                            onPressed: () {},
                                          ),
                                          SizedBox(width: 10),
                                          IconButton(
                                            icon: Icon(FontAwesomeIcons.xmark, size: 20),
                                            padding: EdgeInsets.all(8),
                                            onPressed: () => Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 70),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 42, right: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildNavItem(
                                          context: context,
                                          icon: Icons.dashboard_outlined,
                                          title: 'Dashboard',
                                          index: 0,
                                        ),
                                        SizedBox(height: 60),
                                        _buildNavItem(
                                          context: context,
                                          icon: FontAwesomeIcons.calculator,
                                          title: 'Set Budget',
                                          index: 1,
                                        ),
                                        SizedBox(height: 60),
                                        _buildNavItem(
                                          context: context,
                                          icon: FontAwesomeIcons.chartSimple,
                                          title: 'Expense Report',
                                          index: 2,
                                        ),
                                        SizedBox(height: 60),
                                        _buildNavItem(
                                          context: context,
                                          icon: Icons.lightbulb_outline,
                                          title: 'Recommendation',
                                          index: 3,
                                        ),
                                        SizedBox(height: 60),
                                        _buildNavItem(
                                          context: context,
                                          icon: Icons.logout,
                                          title: 'Log Out',
                                          color: Colors.red,
                                          index: -1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      title: Text(
        'AptTraq',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: ElevatedButton(
            child: Icon(Icons.add, size: 25, color: Colors.white),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(6),
                backgroundColor: AppColors.primaryColor,
                minimumSize: Size(40, 55)
            ),
            onPressed: () {
              showDialog(context: context, builder: (context)=> const AddExpenseDialog());
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddExpenseDialog()));
            },
          ),
        ),
        SizedBox(width: 8),
        CircleAvatar(
          radius: 16,
        ),
        SizedBox(width: 16),
        Icon(Icons.arrow_drop_down),
      ],
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required int index,
    Color? color,
  }) {
    final isSelected = index == currentIndex;
    return InkWell(
      onTap: () {
        if (index != -1) {
          onIndexChanged(index);
          Navigator.pop(context); // Close drawer
        } else {
          // Handle logout
          Navigator.pop(context);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
                (route) => false,
          );
        }
      },
      child: Row(
        children: [
          Icon(
            icon,
            size: 26,
            color: color ?? Colors.black87,
          ),
          SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: color ?? Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


