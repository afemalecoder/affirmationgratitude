import 'package:flutter/material.dart';

class AffirmationAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AffirmationAppBar({
    Key? key,
    required this.label,
    required this.tag,
    this.showBackButton = false,
  }) : super(key: key);

  final String label;
  final String tag;
  final bool showBackButton;

  @override
  _AffirmationAppBarState createState() => _AffirmationAppBarState();

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}

class _AffirmationAppBarState extends State<AffirmationAppBar> {
  double opacity = 0.0;

  void _updateBackButtonOpacity() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() => opacity = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    _updateBackButtonOpacity();
    return Hero(
      tag: widget.tag,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          height: double.infinity,
          child: _AppBarCard(
            children: [
              if (widget.showBackButton)
                _AffirmationAppBarBackButton(opacity: opacity),
              if (!widget.showBackButton) const SizedBox(width: 15),
              _AffirmationAppBarTitle(widget: widget),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBarCard extends StatelessWidget {
  const _AppBarCard({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      elevation: 10,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            const SizedBox(width: 25),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _AffirmationAppBarTitle extends StatelessWidget {
  const _AffirmationAppBarTitle({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final AffirmationAppBar widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.label,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}

class _AffirmationAppBarBackButton extends StatelessWidget {
  const _AffirmationAppBarBackButton({
    Key? key,
    required this.opacity,
  }) : super(key: key);

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: opacity,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () => Navigator.of(context).pop(),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
