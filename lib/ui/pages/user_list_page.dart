part of 'pages.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  TextEditingController searchController = TextEditingController();
  bool isNotEmpty = false;

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
                Icons.people,
                size: Screen.isMobile(context) ? 22 : 40,
                color: blue,
              ),
              SizedBox(width: 16),
              Text(
                'Users',
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
                  userController.getUsers();
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
                userController.search(searchController.text);
                setState(() => isNotEmpty = true);
              } else {
                userController.getUsers();
                setState(() => isNotEmpty = false);
              }
            },
          ),
        ),
        // list
        Container(
          margin: EdgeInsets.all(Screen.isMobile(context) ? defMargin : 40),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: GetBuilder<UserController>(
            init: UserController(),
            builder: (state) {
              if (state.users.length != 0) {
                return Column(
                  children: state.users
                      .map((e) => Padding(
                            padding: EdgeInsets.only(
                              bottom: e == state.users.last ? 0 : 10,
                            ),
                            child: InkWell(
                              onTap: () =>
                                  Get.toNamed('/detailUser', arguments: e),
                              child: UserListItem(e),
                            ),
                          ))
                      .toList(),
                );
              } else {
                return isNotEmpty
                    ? IllustrationPage('User not found')
                    : IllustrationPage('No users');
              }
            },
          ),
        ),
      ],
    );
  }
}
