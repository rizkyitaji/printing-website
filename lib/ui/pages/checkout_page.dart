part of 'pages.dart';

class CheckoutPage extends StatelessWidget {
  final Product product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      child: ListView(
        children: [
          SizedBox(height: Screen.small(context) ? 0 : 80),
          Breadcrumb(
            nav: ['detail', 'checkout'],
            active: 'checkout',
            arg: product,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(defMargin),
            color: Colors.white,
            child: Column(
              children: [
                Screen.small(context)
                    ? Column(children: detailProduct(context))
                    : Row(children: detailProduct(context)),
              ],
            ),
          ),
          SizedBox(height: defMargin),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(defMargin),
            color: Colors.white,
            child: buyerData(context),
          ),
          footerSection,
        ],
      ),
    );
  }

  List<Widget> detailProduct(BuildContext context) {
    return [
      Container(
        width: Screen.small(context) ? double.infinity : 250,
        height: 250,
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
        width: Screen.small(context) ? double.infinity : context.width - 338,
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name, style: poppins.copyWith(fontSize: 24)),
            Text(
              product.description,
              maxLines: 3,
              style: poppins.copyWith(color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
            GetBuilder<OrderController>(
              init: OrderController(),
              builder: (state) => Text(
                state.totalPrice(product.price1, product.price2),
                style: poppins.copyWith(fontSize: 16),
              ),
            ),
            Row(
              children: [
                Text('Total Order :', style: poppins.copyWith(fontSize: 16)),
                SizedBox(width: 40),
                InkWell(
                  onTap: () => orderController.minOrder(),
                  child: Image.asset(
                    'assets/btn_min.png',
                    width: 26,
                    height: 26,
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: GetX<OrderController>(
                    init: OrderController(),
                    builder: (state) => Text(
                      state.quantity.value.toString(),
                      style: poppins.copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => orderController.maxOrder(),
                  child: Image.asset(
                    'assets/btn_add.png',
                    width: 26,
                    height: 26,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ];
  }

  Widget buyerData(BuildContext context) {
    return Center(
      child: Container(
        width: Screen.small(context) ? double.infinity : 1000,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                'Deliver to : ',
                style: poppins.copyWith(fontSize: 18),
              ),
            ),
            SizedBox(height: 12),
            formField('Name', userController.user.name),
            formField('Address', userController.user.address),
            formField('City', userController.user.city),
            formField('Phone No.', userController.user.phone),
            Container(
              width: 150,
              height: 45,
              margin: EdgeInsets.symmetric(vertical: defMargin),
              child: ElevatedButton(
                style: mainButtonStyle,
                child: Text('CHECKOUT'),
                onPressed: () async {
                  bool result = await orderController.submitOrder(
                    Order(
                      product: product,
                      quantity: orderController.quantity.value,
                      total1: orderController.total1.value,
                      total2: orderController.total2.value,
                      date: DateTime.now(),
                      user: userController.user,
                    ),
                  );

                  String msg = orderController.message;

                  if (result) {
                    orderController.clear();
                    Toast.show(msg, context,
                        backgroundColor: green, duration: 2);
                    Get.offNamed('/?index=3');
                  } else {
                    Toast.show(msg, context, backgroundColor: red, duration: 2);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formField(String attribute, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 70, child: Text(attribute, style: poppins)),
          Spacer(),
          colon,
          Spacer(),
          Expanded(
            flex: 14,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: Colors.black),
              ),
              child: Text(text, style: poppins),
            ),
          ),
        ],
      ),
    );
  }
}
