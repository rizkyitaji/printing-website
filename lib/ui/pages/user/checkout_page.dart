part of 'user.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Product product = Get.arguments;
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var phoneController = TextEditingController();
  bool invalidName = false;
  bool invalidAddress = false;
  bool invalidCity = false;
  bool invalidPhone = false;

  @override
  void initState() {
    super.initState();
    nameController.text = userController.user.name;
    addressController.text = userController.user.address;
    cityController.text = userController.user.city;
    phoneController.text = userController.user.phone;
  }

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
          Footer(),
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
            OptionListItem(
              product: product,
              tag: 'checkout',
            ),
            GetBuilder<OrderController>(
              init: OrderController(),
              builder: (state) => Row(
                children: [
                  Container(
                    width: 100,
                    margin: EdgeInsets.only(right: 12),
                    child: Text(
                      'Price',
                      style: poppins.copyWith(fontSize: 16),
                    ),
                  ),
                  colon,
                  SizedBox(width: 12),
                  Text(
                    state.totalPrice(product.option.price),
                    style: poppins.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  margin: EdgeInsets.only(right: 12),
                  child: Text(
                    'Total Order',
                    style: poppins.copyWith(fontSize: 16),
                  ),
                ),
                colon,
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
            formField(
              field: 'Name',
              controller: nameController,
              hintText: 'Type your full name',
              validator: invalidName,
            ),
            formField(
              field: 'Address',
              controller: addressController,
              hintText: 'Type your address',
              validator: invalidAddress,
            ),
            formField(
              field: 'City',
              controller: cityController,
              hintText: 'Type your city',
              validator: invalidCity,
            ),
            formField(
              field: 'Phone No.',
              controller: phoneController,
              hintText: 'Type your phone number',
              validator: invalidPhone,
            ),
            Container(
              width: 150,
              height: 45,
              margin: EdgeInsets.symmetric(vertical: defMargin),
              child: ElevatedButton(
                style: mainButtonStyle,
                child: Text('CHECKOUT'),
                onPressed: () async {
                  if (nameController.text.isEmpty) {
                    setState(() => invalidName = true);
                  } else if (addressController.text.isEmpty) {
                    setState(() => invalidAddress = true);
                  } else if (cityController.text.isEmpty) {
                    setState(() => invalidCity = true);
                  } else if (phoneController.text.isEmpty) {
                    setState(() => invalidPhone = true);
                  } else {
                    submitOrder(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submitOrder(BuildContext context) async {
    User user = userController.user;

    bool result = await orderController.submitOrder(
      Order(
        product: product,
        quantity: orderController.quantity.value,
        total: orderController.total.value,
        date: DateTime.now(),
        user: user.copyWith(
          name: nameController.text,
          address: addressController.text,
          city: cityController.text,
          phone: phoneController.text.trim(),
        ),
      ),
    );

    String msg = orderController.message;

    if (result) {
      orderController.clear();
      Toast.show(msg, context, backgroundColor: green, duration: 2);
      Get.toNamed('/?index=2');
    } else {
      Toast.show(msg, context, backgroundColor: red, duration: 2);
    }
  }

  Widget formField({
    String field,
    TextEditingController controller,
    String hintText,
    bool validator,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(field, style: poppins),
          ),
          Spacer(),
          colon,
          Spacer(),
          Expanded(
            flex: 14,
            child: CustomTextField(
              controller: controller,
              boxColor: Colors.white,
              borderColor: Colors.black,
              hintText: hintText,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}
