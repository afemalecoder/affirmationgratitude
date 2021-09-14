import 'package:flutter/material.dart';

class HomeCategoryCard extends StatelessWidget {
  const HomeCategoryCard({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Card(
        color: const Color(0xff8793FA),
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shadowColor: const Color(0xffC1C8FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Text>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: Color(0xffffffff),
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color(0xffC1C8FF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
