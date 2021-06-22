part of 'admin.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.all(Screen.isMobile(context) ? defMargin : 40),
          child: Row(
            children: [
              Icon(
                Icons.home,
                size: Screen.isMobile(context) ? 22 : 40,
                color: blue,
              ),
              SizedBox(width: 16),
              Text(
                'Home',
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
          color: Colors.white,
          alignment: Alignment.center,
          padding: EdgeInsets.all(40),
          child: Wrap(
            spacing: defMargin,
            runSpacing: defMargin,
            children: [
              Obx(() {
                return cardMenu(
                  context,
                  color: red,
                  title: 'Users',
                  icon: Icons.people,
                  length: userController.count,
                );
              }),
              Obx(() {
                return cardMenu(
                  context,
                  color: blue,
                  title: 'Products',
                  icon: Icons.view_list,
                  length: productController.count,
                );
              }),
              Obx(() {
                return cardMenu(
                  context,
                  color: green,
                  title: 'Orders',
                  icon: Icons.list_alt,
                  length: orderController.count,
                );
              }),
              cardMenu(
                context,
                color: Colors.amber,
                title: 'Company',
                icon: Icons.admin_panel_settings,
                onTap: () => Get.toNamed('/companyProfile'),
              ),
            ],
          ),
        ),
        SizedBox(height: defMargin),
        Footer(),
      ],
    );
  }

  Widget cardMenu(BuildContext context,
      {Color color, String title, IconData icon, int length, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: color,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: 350,
          height: 150,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: defMargin,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 120, color: Colors.white),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(title == 'Company' ? title : 'Total $title',
                      style: whiteFontStyle),
                  Text(title == 'Company' ? 'Profile' : '$length ' + title,
                      style: whiteFontStyle),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
