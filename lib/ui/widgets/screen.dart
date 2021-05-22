part of 'widgets.dart';

class Screen extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  Screen({
    @required this.mobile,
    this.tablet,
    @required this.desktop,
  });

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool small(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool medium(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width <= 1300;
  }

  static bool large(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1300;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1300) {
          return desktop;
        } else if (constraints.maxWidth >= 600) {
          return tablet ?? desktop;
        } else {
          return mobile;
        }
      },
    );
  }
}
