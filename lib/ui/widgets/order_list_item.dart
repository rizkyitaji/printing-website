part of 'widgets.dart';

class OrderListItem extends StatelessWidget {
  final Order order;

  OrderListItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          margin: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(order.product.picturePath),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.product.name,
                style: poppins.copyWith(fontSize: 16),
                overflow: TextOverflow.clip,
              ),
              SizedBox(height: 12),
              Text(
                '${order.quantity} item(s) : IDR ${order.total1} - ${order.total2}',
                style: poppins.copyWith(color: grey, fontSize: 13),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                convertDateTime(order.date),
                style: poppins.copyWith(color: grey, fontSize: 12),
              ),
              SizedBox(height: 12),
              (order.status == OrderStatus.cancelled)
                  ? orderStatus('Cancelled', red)
                  : (order.status == OrderStatus.pending)
                      ? orderStatus('Pending', red)
                      : (order.status == OrderStatus.on_process)
                          ? orderStatus('On Process', Colors.amber)
                          : (order.status == OrderStatus.on_delivery)
                              ? orderStatus('On Delivery', green)
                              : (order.status == OrderStatus.delivered)
                                  ? orderStatus('Delivered', green)
                                  : SizedBox(),
            ],
          ),
        ),
        SizedBox(
          width:
              userController.user.level.compareTo('user') == 0 ? 0 : defMargin,
        ),
        userController.user.level.compareTo('admin') == 0
            ? InkWell(
                onTap: () async {
                  bool result = await orderController.delete(order.id);

                  if (result) {
                    Toast.show(
                        'Order by ${order.user.name} has been deleted', context,
                        backgroundColor: green);
                  } else {
                    Toast.show(productController.message, context,
                        backgroundColor: red);
                  }
                },
                child: Icon(Icons.delete),
              )
            : SizedBox(),
      ],
    );
  }

  Widget orderStatus(String text, Color color) {
    return Text(
      text,
      style: statusFontStyle.copyWith(
        color: color,
      ),
    );
  }

  String convertDateTime(DateTime dateTime) {
    String month;

    switch (dateTime.month) {
      case 1:
        month = 'Jan';
        break;
      case 2:
        month = 'Feb';
        break;
      case 3:
        month = 'Mar';
        break;
      case 4:
        month = 'Apr';
        break;
      case 5:
        month = 'May';
        break;
      case 6:
        month = 'Jun';
        break;
      case 7:
        month = 'Jul';
        break;
      case 8:
        month = 'Aug';
        break;
      case 9:
        month = 'Sep';
        break;
      case 10:
        month = 'Oct';
        break;
      case 11:
        month = 'Nov';
        break;
      default:
        month = 'Dec';
    }

    return month + ' ${dateTime.day}, ${dateTime.hour}:${dateTime.minute}';
  }
}
