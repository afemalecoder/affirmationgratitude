import 'package:flutter/material.dart';

//Getting the screens width and height
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
Size deviceSize(BuildContext context) => MediaQuery.of(context).size;

//Getting the pixel amount for the percent of the screens height and width.
double screenHeightPercent(BuildContext context, {double percent = 1}) {
  return screenHeight(context) * percent;
}

double screenWidthPercent(BuildContext context, {double percent = 1}) {
  return screenWidth(context) * percent;
}
