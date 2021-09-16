part of home;

/// This is the decoration background for the home screen.
///
/// To use it, the parent widget in the [Scaffold] (widget present in the body)
/// should be wrapped in [CustomPaint] and, [BackgroundCustomPaint] assigned to
/// the parameter named "[painter]" in the [CustomPaint] Widget itself.
///
/// Steps taken when drawing the shapes
/// 1. Define the instruction of the shape you desire using [Path]
/// 2. Assign properties eg. color or style by calling [Paint]
/// 3. Call [Canvas] and pass in the [Path] and [Paint] to draw
class _BackgroundCustomPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const Color overlayColor = Color(0xffC1C8FF);
    const Color filledColor = Color(0xffECEFFF);

    const double overlayRadius = 32;
    const double strokeWidth = 6;
    final height = size.height;
    final width = size.width;

    final Path filledCircleDeco = Path();
    final Path filledBackgroundDeco = Path();
    final Path strokedDeco = Path();

    /// ============== START Stroked Circle ==============
    strokedDeco.addOval(
      Rect.fromCircle(
        center: Offset(width * 0.95, -50),
        radius: 100,
      ),
    );
    // cascade operators
    final strokedCirclePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = overlayColor;

    canvas.drawPath(strokedDeco, strokedCirclePaint);

    /// ============== END Stroked shape ==============
    ///
    /// ============== START Filled Circle ==============
    filledCircleDeco.addOval(
      Rect.fromCircle(
        center: Offset(width * 0.1, -50),
        radius: 100,
      ),
    );

    final filledCirclePaint = Paint()
      ..color = filledColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(filledCircleDeco, filledCirclePaint);

    /// ============== END Filled Circle ==============
    ///
    /// ============== START Background Overlay ==============
    filledBackgroundDeco.addRRect(
      RRect.fromRectAndCorners(
        Rect.fromPoints(
          Offset(width, height),
          Offset(0, height * 0.25),
        ),
        topLeft: const Radius.circular(overlayRadius),
        topRight: const Radius.circular(overlayRadius),
      ),
    );
    final filledBackgroundPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(filledBackgroundDeco, filledBackgroundPaint);

    /// ============== END Background Overlay ==============
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
