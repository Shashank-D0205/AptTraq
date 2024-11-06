import 'package:flutter/material.dart';
import 'package:pennyflow/Nav_bar.dart';
import 'package:pennyflow/header.dart';

class Profile extends StatefulWidget {

  final Function(int) onIndexChanged;
  final int currentIndex;

  Profile({
    Key? key,
    required this.onIndexChanged,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                children: [
                  PageHeader(title: 'Profile')
                ],
              )
          )
        ],
      ),
    );
  }
}
