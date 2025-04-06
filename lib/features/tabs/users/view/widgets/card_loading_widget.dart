import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardLoadingWidget extends StatelessWidget {
  const CardLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        children: [
          CircleAvatar(backgroundColor: Colors.grey, radius: 30),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10, color: Colors.grey[300]),
                SizedBox(height: 5),
                Container(height: 10, color: Colors.grey[300]),
              ],
            ),
          ),
          SizedBox(width: 10),
          Container(width: 100, height: 30, color: Colors.grey[300]),
        ],
      ),
    );
  }
}
