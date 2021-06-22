part of 'admin.dart';

class AdminPage extends StatefulWidget {
  final int index;
  final bool isNotHome;
  final Widget child;

  AdminPage({this.index, this.isNotHome = false, this.child});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int selectedIndex;
  var arg = Get.arguments;

  @override
  void initState() {
    super.initState();
    userController.getCount();
    userController.getUsers();
    orderController.getCount();
    orderController.getOrders();
    productController.getCount();
    selectedIndex = widget.isNotHome ? widget.index : (arg != null ? arg : 0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.isNotHome) {
          Get.toNamed(
            '/admin',
            arguments: widget.index,
          );
          return true;
        } else {
          return false;
        }
      },
      child: Screen(
        mobile: mobileView(),
        desktop: desktopView(),
      ),
    );
  }

  Widget mobileView() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: blue,
        title: GetX<ProfileController>(
          init: ProfileController(),
          builder: (state) {
            if (state.profile.picturePath == null) {
              return SizedBox();
            } else {
              return Text(state.profile.name, style: whiteFontStyle);
            }
          },
        ),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Container(color: Colors.lightBlue[100]),
            ListView(
              children: [
                Obx(() {
                  return DrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            NetworkImage(profileController.profile.picturePath),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: SizedBox(),
                  );
                }),
                ListTile(
                  tileColor: blue,
                  leading: Icon(Icons.home, color: Colors.white),
                  title: Text('Home', style: whiteFontStyle),
                  onTap: () {
                    if (widget.isNotHome) {
                      Get.toNamed('/admin', arguments: 0);
                    } else {
                      setState(() => selectedIndex = 0);
                      Get.close(1);
                    }
                  },
                ),
                SizedBox(height: 1),
                ListTile(
                  tileColor: blue,
                  leading: Icon(Icons.people, color: Colors.white),
                  title: Text('Users', style: whiteFontStyle),
                  onTap: () {
                    if (widget.isNotHome) {
                      Get.toNamed('/admin', arguments: 1);
                    } else {
                      setState(() => selectedIndex = 1);
                      Get.close(1);
                    }
                  },
                ),
                SizedBox(height: 1),
                ListTile(
                  tileColor: blue,
                  leading: Icon(Icons.home, color: Colors.white),
                  title: Text('Products', style: whiteFontStyle),
                  onTap: () {
                    if (widget.isNotHome) {
                      Get.toNamed('/admin', arguments: 2);
                    } else {
                      setState(() => selectedIndex = 2);
                      Get.close(1);
                    }
                  },
                ),
                SizedBox(height: 1),
                ListTile(
                  tileColor: blue,
                  leading: Icon(Icons.list_alt, color: Colors.white),
                  title: Text('Orders', style: whiteFontStyle),
                  onTap: () {
                    if (widget.isNotHome) {
                      Get.toNamed('/admin', arguments: 3);
                    } else {
                      setState(() => selectedIndex = 3);
                      Get.close(1);
                    }
                  },
                ),
                SizedBox(height: 1),
                ListTile(
                  tileColor: blue,
                  leading: Icon(Icons.logout, color: Colors.white),
                  title: Text('Sign Out', style: whiteFontStyle),
                  onTap: () {
                    userController.clear();
                    Get.toNamed('/');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: widget.isNotHome ? widget.child : selectedMenu(),
      ),
      floatingActionButton: widget.isNotHome || selectedIndex != 2
          ? SizedBox()
          : floatingActionButton(),
    );
  }

  Widget desktopView() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: blue,
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              minWidth: 90,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.people_outline),
                  selectedIcon: Icon(Icons.people),
                  label: Text('Users'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.view_list_outlined),
                  selectedIcon: Icon(Icons.view_list),
                  label: Text('Products'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.list_alt_outlined),
                  selectedIcon: Icon(Icons.list_alt),
                  label: Text('Orders'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.exit_to_app_outlined),
                  selectedIcon: Icon(Icons.exit_to_app),
                  label: Text('Sign Out'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                if (index == 4) {
                  userController.clear();
                  Get.toNamed('/');
                } else {
                  widget.isNotHome
                      ? Get.toNamed('/admin', arguments: index)
                      : setState(() => selectedIndex = index);
                }
              },
              labelType: NavigationRailLabelType.selected,
              selectedIconTheme: IconThemeData(color: Colors.white),
              unselectedIconTheme: IconThemeData(color: Colors.white),
              selectedLabelTextStyle: whiteFontStyle,
              backgroundColor: blue,
            ),
            Expanded(
              child: widget.isNotHome ? widget.child : selectedMenu(),
            ),
          ],
        ),
      ),
      floatingActionButton: widget.isNotHome || selectedIndex != 2
          ? SizedBox()
          : floatingActionButton(),
    );
  }

  Widget selectedMenu() {
    switch (selectedIndex) {
      case 0:
        return HomePage();
        break;
      case 1:
        return UserListPage();
        break;
      case 2:
        return ProductListPage();
        break;
      default:
        return OrderListPage();
    }
  }

  Widget floatingActionButton() {
    return Container(
      margin: EdgeInsets.only(right: 16, bottom: 16),
      child: FloatingActionButton(
        onPressed: () => Get.toNamed('/addProduct'),
        child: Icon(Icons.add),
      ),
    );
  }
}
