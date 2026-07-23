import 'package:flutter/material.dart';

class TapItems extends StatelessWidget {
  const TapItems({super.key, required this.title, required this.count});
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, overflow: TextOverflow.ellipsis),
          count > 0
              ? Container(
                  margin: EdgeInsetsDirectional.only(start: 5),
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      count > 9 ? '9+' : count.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
