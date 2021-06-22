part of 'user.dart';

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
          Footer(),
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
      SizedBox(width: 40),
      SizedBox(
        width: Screen.small(context) ? double.infinity : context.width - 488,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height:
                  context.width >= 860 && context.width < 1000 ? 0 : defMargin,
            ),
            Text(product.name, style: poppins.copyWith(fontSize: 24)),
            SizedBox(height: defMargin),
            OptionListItem(
              tag: detail,
              product: detail == 'order' ? order.product : product,
            ),
            SizedBox(height: 40),
            context.width >= 860 && context.width < 1000 ||
                    Screen.isMobile(context)
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
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Price', style: poppins.copyWith(fontSize: 18)),
              SizedBox(width: 16),
              colon,
              SizedBox(width: 16),
              Text(
                detail == 'order'
                    ? '${Currency.format(order.product.option.price)}'
                    : '${Currency.format(product.options.first.price)} - ${Currency.format(product.options.last.price)}',
                style: poppins.copyWith(fontSize: 18),
              ),
            ],
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
                top: context.width >= 860 && context.width < 1000 ||
                        Screen.isMobile(context)
                    ? defMargin
                    : 0,
              ),
              child: ElevatedButton(
                style: mainButtonStyle,
                child: Text('ORDER'),
                onPressed: () {
                  Get.toNamed(
                    '/checkout',
                    arguments: product.copyWith(
                      option: productController.option,
                    ),
                  );
                },
              ),
            )
          : SizedBox(),
    ];
  }

  Widget orderStatus(String text, Color color) {
    return Text(text, style: poppins.copyWith(color: color, fontSize: 16));
  }
}
