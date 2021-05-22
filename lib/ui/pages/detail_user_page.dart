part of 'pages.dart';

class DetailUserPage extends StatelessWidget {
  final User user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return AdminPage(
      index: 1,
      isNotHome: true,
      child: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(Screen.isMobile(context) ? defMargin : 40),
            child: Row(
              children: [
                Icon(
                  Icons.people,
                  size: Screen.isMobile(context) ? 22 : 40,
                  color: blue,
                ),
                SizedBox(width: 16),
                Text(
                  'Detail User',
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
            color: Colors.white,
            padding: EdgeInsets.all(40),
            child: Column(
              children: [
                formField('Name', user.name),
                formField('Email', user.email),
                formField('Password', user.password),
                formField('Phone No.', user.phone),
                formField('Address', user.address),
                formField('City', user.city),
                formField('Level', user.level),
              ],
            ),
          ),
          SizedBox(height: defMargin),
        ],
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
              child: Text(text, style: poppins),
            ),
          ),
        ],
      ),
    );
  }
}
