import 'package:flutter/material.dart';
import 'package:pennyflow/values/values.dart';

class NavItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final bool isSelected;
  final VoidCallback onTap;
  final Color textColor;
  final Color iconColor;

  const NavItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.route,
    required this.isSelected,
    required this.onTap,
    this.textColor = AppColors.secondaryColor,
    this.iconColor = AppColors.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.white : iconColor,
            ),
            SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? AppColors.white : textColor,
                fontWeight: isSelected ? FontWeight.normal : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

