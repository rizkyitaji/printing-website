part of 'widgets.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputAction action;
  final TextInputType type;
  final TextCapitalization caps;
  final double marginTop;
  final double marginLeft;
  final double marginRight;
  final double marginBottom;
  final double width;
  final String hintText;
  final bool password;
  final bool email;
  final int maxLines;
  bool obscureText;
  bool validator;

  CustomTextField({
    @required this.controller,
    this.action,
    this.type,
    this.caps = TextCapitalization.none,
    this.marginTop = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.marginBottom = 0,
    this.width = double.infinity,
    this.hintText,
    this.password = false,
    this.email = false,
    this.maxLines = 1,
    this.obscureText = false,
    this.validator = false,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: widget.width,
          margin: EdgeInsets.only(
            left: widget.marginLeft,
            top: widget.marginTop,
            right: widget.marginRight,
            bottom: widget.marginBottom,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.lightBlue[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: widget.controller,
            obscureText: widget.obscureText,
            textInputAction: widget.action,
            textCapitalization: widget.caps,
            keyboardType: widget.type,
            maxLines: widget.maxLines,
            style: poppins.copyWith(fontSize: 12),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: poppins.copyWith(
                color: Colors.black54,
                fontSize: 12,
              ),
              suffixIcon: widget.password
                  ? InkWell(
                      onTap: () {
                        if (widget.obscureText == true) {
                          setState(() => widget.obscureText = false);
                        } else {
                          setState(() => widget.obscureText = true);
                        }
                      },
                      child: Icon(
                        widget.obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                    )
                  : SizedBox(),
              suffixIconConstraints: BoxConstraints(),
              contentPadding:
                  EdgeInsets.fromLTRB(0, 10, widget.password ? 10 : 0, 10),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() => widget.validator = false);
              }
            },
          ),
        ),
        widget.validator && widget.controller.text.isEmpty
            ? errorText("Please fill in this field")
            : widget.password &&
                    widget.validator &&
                    widget.controller.text.length < 8
                ? errorText("Password must be at least 8 characters")
                : widget.email &&
                        widget.validator &&
                        !widget.controller.text.contains('@')
                    ? errorText("Invalid value for email address")
                    : SizedBox()
      ],
    );
  }

  Widget errorText(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: [
          SizedBox(width: widget.marginLeft),
          Icon(Icons.error, color: red, size: 12),
          SizedBox(width: 4),
          Text(
            text,
            style: statusFontStyle.copyWith(color: red),
          ),
        ],
      ),
    );
  }
}
