import 'package:flutter/material.dart';
import 'package:pennyflow/Auth/LogIn.dart';
import 'Screens/Dashboard/Dashboard Screen.dart';
import 'Screens/SetBudget/Set_Budget.dart';
import 'nav_item.dart';
import 'values/values.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavBar extends StatefulWidget {
  final Function(int) onIndexChanged;
  final int currentIndex;

  const NavBar({
    Key? key,
    required this.onIndexChanged,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(
              'AptTraq',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          SizedBox(height: 40),
          Expanded(
            child: ListView(
              children: [
                NavItem(
                  title: 'Dashboard',
                  icon: Icons.dashboard_outlined,
                  route: Dashboard_SC.DashboardPageRoute,
                  isSelected: widget.currentIndex == 0,
                  onTap: () => widget.onIndexChanged(0),
                ),
                SizedBox(height: 20),
                NavItem(
                  title: 'Set Budget',
                  icon: FontAwesomeIcons.calculator,
                  route: SetBudget.setbudgetPageroute,
                  isSelected: widget.currentIndex == 1,
                  onTap: () => widget.onIndexChanged(1),
                ),
                SizedBox(height: 20),
                NavItem(
                  title: 'Expense Report',
                  icon: FontAwesomeIcons.chartSimple,
                  route: '/expense_report',
                  isSelected: widget.currentIndex == 2,
                  onTap: () => widget.onIndexChanged(2),
                ),
                SizedBox(height: 20),
                NavItem(
                  title: 'Recommendation',
                  icon: FontAwesomeIcons.lightbulb,
                  route: '/recommendation',
                  isSelected: widget.currentIndex == 3,
                  onTap: () => widget.onIndexChanged(3),
                ),
              ],
            ),
          ),
          NavItem(
            title: 'Log Out',
            icon: Icons.exit_to_app,
            route: '/logout',
            isSelected: false,
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            },
            textColor: Colors.red,
            iconColor: Colors.red,
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }
}