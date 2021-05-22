part of 'pages.dart';

class DetailPage extends StatelessWidget {
  final Order order =
      Get.parameters['detail'] == 'order' ? Get.arguments : null;
  final String detail = Get.parameters['detail'];
  final Product product = Get.parameters['detail'] == 'order'
      ? Get.arguments.product
      : Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      child: ListView(
        children: [
          SizedBox(height: Screen.small(context) ? 0 : 80),
          // breadcrumb
          Breadcrumb(
            nav: ['detail'],
            active: 'detail',
            arg: detail == 'order' ? order : product,
          ),
          // content
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(defMargin),
            color: Colors.white,
            child: Column(
              children: [
                Screen.small(context)
                    ? Column(children: detailProduct(context))
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: detailProduct(context),
                      ),
                SizedBox(height: 40),
              ],
            ),
          ),
          footerSection,
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
            image: NetworkImage(product.picturePath),
            fit: BoxFit.fill,
          ),
        ),
      ),
      SizedBox(width: defMargin),
      SizedBox(
        width: Screen.small(context) ? double.infinity : context.width - 472,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height:
                  context.width >= 800 && context.width < 930 ? 0 : defMargin,
            ),
            Text(product.name, style: poppins.copyWith(fontSize: 24)),
            SizedBox(height: defMargin),
            Text(
              product.description,
              style: poppins,
              maxLines: context.width >= 800 && context.width < 930 ? 4 : 10,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 40),
            context.width >= 800 && context.width < 930
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: price(context),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: price(context),
                  ),
          ],
        ),
      )
    ];
  }

  List<Widget> price(BuildContext context) {
    int price1 = detail == 'order' ? order.total1 : product.price1;
    int price2 = detail == 'order' ? order.total2 : product.price2;
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price : IDR $price1 - $price2',
            style: poppins.copyWith(fontSize: 18),
          ),
          SizedBox(height: detail == 'order' ? defMargin : 0),
          detail == 'order'
              ? Row(
                  children: [
                    orderStatus('Order Status : ', Colors.black),
                    (order.status == OrderStatus.cancelled)
                        ? orderStatus('Cancelled', red)
                        : (order.status == OrderStatus.pending)
                            ? orderStatus('Pending', red)
                            : (order.status == OrderStatus.on_process)
                                ? orderStatus('On Process', Colors.amber)
                                : (order.status == OrderStatus.on_delivery)
                                    ? orderStatus('On Delivery', green)
                                    : orderStatus('Delivered', green)
                  ],
                )
              : SizedBox(),
        ],
      ),
      detail == 'product' && userController.login
          ? Container(
              width: 150,
              height: 45,
              margin: EdgeInsets.only(
                right: 40,
                top:
                    context.width >= 800 && context.width < 930 ? defMargin : 0,
              ),
              child: ElevatedButton(
                style: mainButtonStyle,
                child: Text('ORDER'),
                onPressed: () => Get.toNamed('/checkout', arguments: product),
              ),
            )
          : SizedBox(),
    ];
  }

  Widget orderStatus(String text, Color color) {
    return Text(text, style: poppins.copyWith(color: color, fontSize: 16));
  }
}
