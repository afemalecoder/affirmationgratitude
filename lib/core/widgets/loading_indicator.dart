import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    const double size = 35.0;
    return const Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: Color.fromRGBO(255, 255, 255, 0.9),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.4),
        ),
      ),
    );
  }
}
