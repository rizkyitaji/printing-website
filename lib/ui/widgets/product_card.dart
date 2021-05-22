part of 'widgets.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(spreadRadius: 3, blurRadius: 15, color: Colors.black12)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              image: DecorationImage(
                image: NetworkImage(product.picturePath),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            margin:
                EdgeInsets.fromLTRB(12, 12, 12, Screen.large(context) ? 6 : 12),
            child: Text(
              product.name,
              style: poppins.copyWith(fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12),
            child: Text(
              'IDR  ${product.price1} - ${product.price2}',
              style: poppins,
            ),
          ),
        ],
      ),
    );
  }
}
