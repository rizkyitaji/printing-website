part of 'admin.dart';

class DetailOrderPage extends StatefulWidget {
  @override
  _DetailOrderPageState createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  Order order = Get.arguments;
  bool isNotEqual = false;
  List<String> status;
  String selectedItem;

  @override
  void initState() {
    super.initState();
    status = ['Pending', 'Cancelled', 'On Process', 'On Delivery', 'Delivered'];
    selectedItem = (order.status == OrderStatus.pending)
        ? status[0]
        : (order.status == OrderStatus.cancelled)
            ? status[1]
            : (order.status == OrderStatus.on_process)
                ? status[2]
                : (order.status == OrderStatus.on_delivery)
                    ? status[3]
                    : status[4];
  }

  @override
  Widget build(BuildContext context) {
    return AdminPage(
      index: 3,
      isNotHome: true,
      child: ListView(
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
                  'Detail Order',
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
          SizedBox(height: defMargin),
        ],
      ),
    );
  }

  List<Widget> detailProduct(BuildContext context) {
    return [
      Container(
        width: Screen.small(context) ? double.infinity : 300,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            image: NetworkImage(order.product.picturePath),
            fit: BoxFit.fill,
          ),
        ),
      ),
      SizedBox(width: 40),
      SizedBox(
        width: Screen.small(context) ? double.infinity : context.width - 478,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.product.name, style: poppins.copyWith(fontSize: 24)),
            Text(
              'order.product.description',
              maxLines: 3,
              style: poppins.copyWith(color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Total Order  :  ${order.quantity} item(s) / {order.total1} - {order.total2}',
              style: poppins.copyWith(fontSize: 16),
            ),
            Row(
              children: [
                Text('Status', style: poppins),
                SizedBox(width: 12),
                colon,
                Container(
                  width: 150,
                  margin: EdgeInsets.only(left: 12),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<dynamic>(
                    value: selectedItem,
                    style: poppins,
                    isExpanded: true,
                    underline: SizedBox(),
                    items: status
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e, style: poppins),
                            ))
                        .toList(),
                    onChanged: (item) {
                      if (order.status != item) {
                        setState(() {
                          isNotEqual = true;
                          selectedItem = item;
                        });
                      } else {
                        setState(() {
                          isNotEqual = false;
                          selectedItem = item;
                        });
                      }
                    },
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
            formField('Name', order.user.name),
            formField('Address', order.user.address),
            formField('City', order.user.city),
            formField('Phone No.', order.user.phone),
            isNotEqual
                ? Container(
                    width: 150,
                    height: 45,
                    margin: EdgeInsets.only(top: defMargin),
                    child: ElevatedButton(
                      style: mainButtonStyle,
                      child: Text('UPDATE'),
                      onPressed: () async {
                        bool result = await orderController.updateStatus(
                            order.id, selectedItem.toUpperCase());

                        String msg = orderController.message;

                        if (result) {
                          Toast.show(msg, context,
                              backgroundColor: green, duration: 2);
                          Get.toNamed('/admin', arguments: 3);
                        } else {
                          Toast.show(msg, context,
                              backgroundColor: red, duration: 2);
                        }
                      },
                    ),
                  )
                : SizedBox(),
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
