part of 'widgets.dart';

class Breadcrumb extends StatelessWidget {
  final List<String> nav;
  final String active;
  final dynamic arg;

  Breadcrumb({this.nav, this.active, this.arg});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(defMargin),
      child: Row(
        children: [
          InkWell(
            onTap: () => Get.toNamed('/'),
            child: Text('Home', style: poppins),
          ),
          SizedBox(width: 4),
          Row(
            children: nav
                .map((e) => Row(children: [
                      Icon(Icons.chevron_right, size: 18),
                      SizedBox(width: 4),
                      InkWell(
                        onTap: () => Get.toNamed(
                            active == 'checkout' ? '/$e?detail=product' : '/$e',
                            arguments: arg),
                        child: Text(
                          e.capitalizeFirst,
                          style: poppins.copyWith(
                            color: e == active ? darkBlue : Colors.black,
                            fontWeight:
                                e == active ? FontWeight.bold : FontWeight.w500,
                          ),
                        ),
                      ),
                    ]))
                .toList(),
          ),
        ],
      ),
    );
  }
}
