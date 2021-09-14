part of home;

class _BackgroundCustomPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    Path ovalPath = Path();

    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    ovalPath.moveTo(0, height * 0.43);

    // ovalPath.addRRect()

    // Paints a curve from current position to the center
    // The curve turning point is at 36% of height
    // The curve ends at the same height as the start point
    ovalPath.quadraticBezierTo(
      width * 0.5,
      height * 0.2,
      width * width,
      height * 0.33,
    );

    // Paint a line from current position to bottom of screen
    ovalPath.quadraticBezierTo(width, height, width, height);

    // draw remaining line to bottom left side
    ovalPath.lineTo(0, height);

    // Close line to reset it back
    ovalPath.close();

    paint.color = const Color(0xffC1C8FF);
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
