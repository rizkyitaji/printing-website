part of 'pages.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      index: 4,
      child: ListView(
        children: [
          SizedBox(height: Screen.small(context) ? 0 : 80),
          Container(
            width: double.infinity,
            color: blue,
            padding: EdgeInsets.all(defMargin),
            alignment: Alignment.center,
            child: Column(
              children: [
                Icon(Icons.account_circle, size: 150, color: Colors.white),
                SizedBox(height: defMargin),
                Text(
                  userController.user.name,
                  style: whiteFontStyle.copyWith(fontSize: 18),
                ),
                SizedBox(height: defMargin),
                Text(
                  userController.user.address,
                  style: whiteFontStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: defMargin),
          OrderPage(),
          SizedBox(height: defMargin),
          footerSection,
        ],
      ),
    );
  }
}
