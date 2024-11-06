import 'package:flutter/material.dart';
import 'package:pennyflow/values/values.dart';

class OverviewCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String amount;
  final String description;
  final String percent;

  const OverviewCard({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.amount,
    required this.description,
    required this.percent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        final cardWidth = isSmallScreen ? constraints.maxWidth : constraints.maxWidth * 0.9;
        final cardHeight = isSmallScreen ? 130.0 : 150.0;
        final iconSize = isSmallScreen ? 20.0 : 24.0;
        final titleFontSize = isSmallScreen ? 12.0 : 14.0;
        final amountFontSize = isSmallScreen ? 18.0 : 20.0;
        final descriptionFontSize = isSmallScreen ? 10.0 : 12.0;

        return Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Padding(
            padding: EdgeInsets.all(isSmallScreen ? 12.0 : 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                      decoration: BoxDecoration(
                        color: iconColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: iconColor, size: iconSize),
                    ),
                    SizedBox(width: isSmallScreen ? 8 : 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                    fontSize: titleFontSize,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.subheading
                                ),
                              ),
                              Text(
                                percent,
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 10 : 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.percent,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: isSmallScreen ? 4 : 8),
                          Text(
                            amount,
                            style: TextStyle(
                              fontSize: amountFontSize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.amount,
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 12 : 20),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: descriptionFontSize,
                              color: AppColors.subheading,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}