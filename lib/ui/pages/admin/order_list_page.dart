part of 'admin.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  TextEditingController searchController = TextEditingController();
  bool isNotEmpty = false;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(Screen.isMobile(context) ? defMargin : 40),
          child: Row(
            children: [
              Icon(
                Icons.list_alt,
                size: Screen.isMobile(context) ? 22 : 40,
                color: blue,
              ),
              SizedBox(width: 16),
              Text(
                'Orders',
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
        // search
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: Screen.isMobile(context) ? defMargin : 100),
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search',
              contentPadding: EdgeInsets.fromLTRB(0, 10, 10, 10),
              suffixIcon: InkWell(
                onTap: () {
                  searchController.text = '';
                  orderController.getOrders();
                  setState(() => isNotEmpty = false);
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Icon(isNotEmpty ? Icons.close : Icons.search),
              ),
              suffixIconConstraints: BoxConstraints(),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                orderController.search(searchController.text);
                setState(() => isNotEmpty = true);
              } else {
                orderController.getOrders();
                setState(() => isNotEmpty = false);
              }
            },
          ),
        ),
        // list
        Container(
          margin: EdgeInsets.all(Screen.isMobile(context) ? defMargin : 40),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: GetBuilder<OrderController>(
            init: OrderController(),
            builder: (state) {
              if (state.orders.length != 0) {
                return Column(
                  children: state.orders
                      .map((e) => Padding(
                            padding: EdgeInsets.only(
                              bottom: e == state.orders.last ? 0 : 10,
                            ),
                            child: InkWell(
                              onTap: () =>
                                  Get.toNamed('/detailOrder', arguments: e),
                              child: OrderListItem(e),
                            ),
                          ))
                      .toList(),
                );
              } else {
                return isNotEmpty
                    ? IllustrationPage('Order not found')
                    : IllustrationPage('No orders');
              }
            },
          ),
        ),
      ],
    );
  }
}
