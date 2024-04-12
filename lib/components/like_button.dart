import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final bool isLiked;
  final VoidCallback onTap;
  final int likeCount;

  const LikeButton({
    required this.isLiked,
    required this.onTap,
    required this.likeCount,
    Key? key,
  }) : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            widget.isLiked ? Icons.favorite : Icons.favorite_border,
            color: widget.isLiked ? Colors.red : null,
          ),
          onPressed: widget.onTap,
        ),
        Text(widget.likeCount.toString()),
      ],
    );
  }
}
