part of 'user.dart';

class PaymentPage extends StatelessWidget {
  final Order order = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      child: ListView(
        children: [
          SizedBox(height: Screen.small(context) ? 0 : 80),
          Breadcrumb(
            nav: ['detail', 'checkout', 'payment'],
            active: 'payment',
            arg: order.product,
          ),
          Container(
            width: double.infinity,
            height: context.height - 150,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/order_success.png',
                  width: 250,
                  height: 250,
                ),
                Text(
                  "You've Made Order",
                  style: poppins.copyWith(
                    fontSize: 18,
                    color: green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Finish your payment now by transfer it to :',
                    style: poppins,
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.payment,
                      color: blue,
                    ),
                    SizedBox(width: 12),
                    Text(
                      '${profileController.profile.bank.account} - ${profileController.profile.bank.name}',
                      style: poppins.copyWith(color: blue),
                    ),
                  ],
                ),
                Container(
                  width: 200,
                  height: 45,
                  margin: EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    style: mainButtonStyle,
                    child: Text('View Orders'),
                    onPressed: () => Get.toNamed('/?index=2'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
