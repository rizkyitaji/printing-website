part of 'widgets.dart';

class ProductListItem extends StatelessWidget {
  final Product product;

  ProductListItem(this.product);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          margin: EdgeInsets.only(right: defMargin),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(product.picturePath),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name, style: poppins.copyWith(fontSize: 16)),
              SizedBox(height: 12),
              Text(
                'IDR ${product.price1} - ${product.price2}',
                style: poppins.copyWith(color: grey),
              ),
            ],
          ),
        ),
        SizedBox(width: defMargin),
        InkWell(
          onTap: () async {
            bool result = await productController.delete(product.id);

            if (result) {
              Toast.show('Product ${product.name} has been deleted', context,
                  backgroundColor: green);
            } else {
              Toast.show(productController.message, context,
                  backgroundColor: red);
            }
          },
          child: Icon(Icons.delete),
        ),
      ],
    );
  }
}
