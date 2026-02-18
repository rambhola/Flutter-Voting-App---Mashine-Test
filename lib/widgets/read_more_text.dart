import 'package:flutter/material.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final int maxLines;

  const ReadMoreText({
    super.key,
    required this.text,
    required this.style,
    this.maxLines = 1,
  });

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    final screenWidth = media.size.width;
    final screenHeight = media.size.height;

    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(text: widget.text, style: widget.style),
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final isOverflowing = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              style: widget.style,
              maxLines: isExpanded ? null : widget.maxLines,
              overflow: isExpanded
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
            ),
            if (isOverflowing)
              // Padding(
              //   padding: const EdgeInsets.only(top: 4),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       setState(() => isExpanded = !isExpanded);
              //     },
              //     child: isExpanded ? Text(" Read Less") : Text("Read More"),
              //   ),
              // ),
              Padding(
                padding: EdgeInsetsGeometry.only(top: 4),
                child: InkWell(
                  onTap: () {
                    setState(() => isExpanded = !isExpanded);
                  },
                  child: Container(
                    height: isLandscape
                        ? screenHeight * 0.07
                        : screenHeight * 0.03,
                    width: isLandscape ? screenWidth * 0.2 : screenWidth * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.yellow, width: 1),
                    ),
                    child: Center(
                      child: isExpanded
                          ? Text(
                              "Read Less ",
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(
                              "Read More",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
