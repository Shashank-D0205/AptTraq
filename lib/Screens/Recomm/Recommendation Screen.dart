import 'package:flutter/material.dart';
import 'package:pennyflow/Nav_bar.dart';
import 'package:pennyflow/values/values.dart';

import '../../header.dart';

class RecommendationSC extends StatefulWidget {
  static const String recommendationPageroute = StringConst.RECOMMENDATION_PAGE;
  final Function(int) onIndexChanged;
  final int currentIndex;

  const RecommendationSC({
    Key? key,
    required this.onIndexChanged,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<RecommendationSC> createState() => _RecommendationSCState();
}

class _RecommendationSCState extends State<RecommendationSC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          NavBar(
              onIndexChanged: widget.onIndexChanged,
              currentIndex: widget.currentIndex
          ),
          Container(
            width: 4,
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: VerticalDivider(
                thickness: 1,
                width: 1,
                color: Colors.grey.shade300,
              ),
            ),
          ),
          Expanded(
              child: Column(
                children: <Widget>[
                  PageHeader(title: StringConst.RECOMMENDATION),
                  Divider(height: 1, thickness: 1, color: Colors.grey[300]),
                  Text('TO DO : UPDATE'),
                ],
              )
          ),

        ],
      ),
    );
  }
}