part of 'pages.dart';

class DetailProductPage extends StatelessWidget {
  final Product product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return AdminPage(
      index: 2,
      isNotHome: true,
      child: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(Screen.isMobile(context) ? defMargin : 40),
            child: Row(
              children: [
                Icon(
                  Icons.view_list,
                  size: Screen.isMobile(context) ? 22 : 40,
                  color: blue,
                ),
                SizedBox(width: 16),
                Text(
                  'Detail Product',
                  style: poppins.copyWith(
                    fontSize: Screen.isMobile(context) ? 14 : 28,
                    color: blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: defMargin),
          Container(
            padding: EdgeInsets.all(40),
            color: Colors.white,
            child: Screen.small(context)
                ? Column(children: detailProduct(context))
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: detailProduct(context),
                  ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  List<Widget> detailProduct(BuildContext context) {
    return [
      Container(
        width: Screen.small(context) ? double.infinity : 400,
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            image: AssetImage(product.picturePath),
            fit: BoxFit.fill,
          ),
        ),
      ),
      SizedBox(width: defMargin, height: defMargin),
      SizedBox(
        width: Screen.small(context) ? double.infinity : context.width - 594,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name, style: poppins.copyWith(fontSize: 24)),
            SizedBox(height: defMargin),
            Text(
              product.description,
              style: poppins,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 40),
            Text(
              'Price : IDR ${product.price1} - ${product.price2}',
              style: poppins.copyWith(fontSize: 18),
            ),
          ],
        ),
      )
    ];
  }
}
