part of 'widgets.dart';

class OptionListItem extends StatefulWidget {
  final Product product;
  final String tag;

  OptionListItem({this.tag, this.product});

  @override
  _OptionListItemState createState() => _OptionListItemState();
}

class _OptionListItemState extends State<OptionListItem> {
  Options _options;

  @override
  void initState() {
    super.initState();
    _options = Options.one;
    productController.option = widget.product.options[0];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tag == 'product') {
      return Column(
        children: [
          listItem(
            value: Options.one,
            index: 0,
          ),
          listItem(
            value: Options.two,
            index: 1,
          ),
          listItem(
            value: Options.three,
            index: 2,
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Option : ', style: poppins.copyWith(fontSize: 16)),
          SizedBox(height: 8),
          ListTile(
            leading: Icon(Icons.check, color: Colors.black),
            title: variant(widget.product.option),
          ),
        ],
      );
    }
  }

  Widget listItem({Options value, int index}) {
    return ListTile(
      leading: Radio<Options>(
        value: value,
        groupValue: _options,
        onChanged: (value) {
          setState(() => _options = value);
          productController.option = widget.product.options[index];
        },
      ),
      title: variant(widget.product.options[index]),
    );
  }

  Widget variant(Option option) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: Text(
            option.variant,
            style: poppins,
          ),
        ),
        SizedBox(width: 16),
        colon,
        SizedBox(width: 16),
        Text(
          Currency.format(option.price),
          style: poppins,
        ),
      ],
    );
  }
}
