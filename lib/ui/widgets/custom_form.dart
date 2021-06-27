part of 'widgets.dart';

class CustomForm extends StatelessWidget {
  final String field;
  final Widget child;
  final List<Widget> children;

  CustomForm({
    @required this.field,
    this.child,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 160,
          margin: EdgeInsets.only(
            top: field == 'Description' ? 4 : 0,
            right: 12,
          ),
          child: Text(field, style: poppins),
        ),
        Container(
          margin: EdgeInsets.only(
            top: field == 'Description' ? 4 : 0,
          ),
          child: colon,
        ),
        Expanded(
          child: child ??
              (children != null
                  ? Row(
                      children: children,
                    )
                  : SizedBox()),
        ),
      ],
    );
  }
}
