part of 'widgets.dart';

class UserListItem extends StatelessWidget {
  final User user;

  UserListItem(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        children: [
          Icon(Icons.account_circle, size: 80),
          SizedBox(width: Screen.isMobile(context) ? defMargin : 40),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: poppins),
                Text(user.email, style: poppins),
              ],
            ),
          ),
          SizedBox(width: 8),
          // InkWell(
          //   onTap: () {},
          //   child: Icon(Icons.edit),
          // ),
          // SizedBox(width: 12),
          InkWell(
            onTap: () async {
              bool result = await userController.delete(user.email);

              if (result) {
                Toast.show('User ${user.name} has been deleted', context,
                    backgroundColor: green);
              } else {
                Toast.show(userController.message, context,
                    backgroundColor: red);
              }
            },
            child: Icon(Icons.delete),
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
