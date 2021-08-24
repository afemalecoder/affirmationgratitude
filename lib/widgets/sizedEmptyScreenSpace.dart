import 'package:flutter/material.dart';

const Widget horizontalSpaceSmallest = SizedBox(height: 5.0);
// Horizontal
const Widget horizontalSpaceSmall = SizedBox(height: 10.0);
const Widget horizontalSpaceRegular = SizedBox(height: 18.0);
const Widget horizontalSpaceMedium = SizedBox(height: 25.0);
const Widget horizontalSpaceLarge = SizedBox(height: 25.0);

//Vertical

const Widget verticalSpaceSmallest = SizedBox(width: 5.0);
const Widget verticalSpaceSmall = SizedBox(width: 10.0);
const Widget verticalSpaceRegular = SizedBox(width: 18.0);
const Widget verticalSpaceMedium = SizedBox(width: 25.0);
const Widget verticalSpaceLarge = SizedBox(width: 50.0);
const Widget verticalSpaceLargest = SizedBox(width: 120.0);

//Getting the screens width and height
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
Size deviceSize(BuildContext context) => MediaQuery.of(context).size;

//Getting the pixel amount for the percent of the screens height and width.
double screenHeightPercent(BuildContext context, {double percent = 1}) =>
    screenHeight(context) * percent;
double screenWidthPercent(BuildContext context, {double percent = 1}) =>
    screenWidth(context) * percent;
