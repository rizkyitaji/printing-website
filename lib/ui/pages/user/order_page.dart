part of 'user.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(40, defMargin, 40, defMargin),
      child: Column(
        children: [
          Text('My Order', style: poppins.copyWith(fontSize: 18)),
          SizedBox(height: 16),
          CustomTabBar(
            titles: ['In Progress', 'Past Order'],
            selectedIndex: selectedIndex,
            onTap: (index) {
              setState(() => selectedIndex = index);
            },
          ),
          SizedBox(height: defMargin),
          StreamBuilder<QuerySnapshot>(
            stream: orderRef
                .where('user.email', isEqualTo: userController.user.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Order> orders = snapshot.data.docs
                    .map((e) => Order.fromSnapshot(e))
                    .toList();
                return Column(
                  children: (selectedIndex == 0
                          ? orders
                              .where((element) =>
                                  element.status == OrderStatus.pending ||
                                  element.status == OrderStatus.on_process ||
                                  element.status == OrderStatus.on_delivery)
                              .toList()
                          : orders
                              .where((element) =>
                                  element.status == OrderStatus.cancelled ||
                                  element.status == OrderStatus.delivered)
                              .toList())
                      .map((e) => Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: InkWell(
                              onTap: () => Get.toNamed('/detail?detail=order',
                                  arguments: e),
                              child: OrderListItem(e),
                            ),
                          ))
                      .toList(),
                );
              } else {
                return Center(
                  child: IllustrationPage('You have not any order yet'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
