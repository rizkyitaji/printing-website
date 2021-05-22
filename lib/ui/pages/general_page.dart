part of 'pages.dart';

// ignore: must_be_immutable
class GeneralPage extends StatefulWidget {
  final AutoScrollController scrollController;
  final Widget child;
  final int index;
  bool isHome;

  GeneralPage({
    this.scrollController,
    this.child,
    this.index,
    this.isHome = false,
  });

  @override
  _GeneralPageState createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  int selectedIndex;

  List<String> nav = ['Home', 'Products', 'About Us', 'Contact'];
  List<String> menu = [
    'Home',
    'Products',
    'Order',
    'About Us',
    'Contact',
    'Profile'
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index;
    if (widget.isHome) {
      widget.scrollController.scrollToIndex(
        widget.index,
        preferPosition: AutoScrollPosition.middle,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Screen.small(context)
          ? AppBar(
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
            )
          : null,
      drawer: Screen.small(context) ? drawer() : SizedBox(),
      body: Stack(
        children: [
          // status bar
          Container(color: blue),
          // background color
          SafeArea(
            child: Container(color: Colors.grey[100]),
          ),
          // content
          SafeArea(
            child: widget.child,
          ),
          // custom appbar
          Screen.small(context) ? SizedBox() : customAppBar(context),
        ],
      ),
    );
  }

  Widget drawer() {
    return Obx(() {
      return Drawer(
        child: Stack(
          children: [
            Container(color: Colors.lightBlue[100]),
            ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          NetworkImage(profileController.profile.picturePath),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: SizedBox(),
                ),
                ListTile(
                  tileColor: blue,
                  title: Text('Home', style: whiteFontStyle),
                  onTap: () {
                    if (widget.isHome) {
                      setState(() => widget.isHome = true);
                      widget.scrollController.scrollToIndex(0,
                          preferPosition: AutoScrollPosition.middle);
                    } else {
                      Get.toNamed("/?index=0");
                    }
                  },
                ),
                SizedBox(height: 1),
                ListTile(
                  tileColor: blue,
                  title: Text('Products', style: whiteFontStyle),
                  onTap: () {
                    if (widget.isHome) {
                      setState(() => widget.isHome = true);
                      widget.scrollController.scrollToIndex(1,
                          preferPosition: AutoScrollPosition.middle);
                    } else {
                      Get.toNamed("/?index=1");
                    }
                  },
                ),
                SizedBox(height: 1),
                userController.login
                    ? ListTile(
                        tileColor: blue,
                        title: Text('Order', style: whiteFontStyle),
                        onTap: () {
                          if (widget.isHome) {
                            setState(() => widget.isHome = true);
                            widget.scrollController.scrollToIndex(2,
                                preferPosition: AutoScrollPosition.middle);
                          } else {
                            Get.toNamed("/?index=2");
                          }
                        },
                      )
                    : SizedBox(),
                SizedBox(height: userController.login ? 1 : 0),
                ListTile(
                  tileColor: blue,
                  title: Text('Contact', style: whiteFontStyle),
                  onTap: () {
                    int index = userController.login ? 3 : 2;
                    if (widget.isHome) {
                      setState(() => widget.isHome = true);
                      widget.scrollController.scrollToIndex(index,
                          preferPosition: AutoScrollPosition.middle);
                    } else {
                      Get.toNamed("/?index=$index");
                    }
                  },
                ),
                SizedBox(height: 1),
                userController.login
                    ? ListTile(
                        tileColor: blue,
                        title: Text('Profile', style: whiteFontStyle),
                        onTap: () => Get.toNamed('/profile'),
                      )
                    : SizedBox(),
                Container(
                  width: double.infinity,
                  height: 45,
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: mainButtonStyle,
                    child: Text(userController.login ? 'Sign Out' : 'Sign In'),
                    onPressed: () {
                      if (userController.login) {
                        userController.clear();
                        orderController.clear();
                        Get.close(1);
                      } else {
                        Get.toNamed('/signin');
                      }
                    },
                  ),
                ),
                userController.login
                    ? SizedBox()
                    : Container(
                        width: double.infinity,
                        height: 45,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          style: mainButtonStyle,
                          child: Text('Sign Up'),
                          onPressed: () => Get.toNamed('/signup'),
                        ),
                      ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget customAppBar(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        height: 80,
        color: blue,
        padding: EdgeInsets.symmetric(horizontal: defMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetX<ProfileController>(
              init: ProfileController(),
              builder: (state) {
                if (state.profile.picturePath == null) {
                  return SizedBox(width: 100);
                } else {
                  return Container(
                    width: 100,
                    margin: EdgeInsets.fromLTRB(0, 12, defMargin, 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(state.profile.picturePath),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 352,
              child: Row(
                children: (userController.login ? menu : nav)
                    .map((e) => Padding(
                          padding: EdgeInsets.only(left: defMargin),
                          child: InkWell(
                            onTap: () {
                              switch (e) {
                                case 'Home':
                                  if (widget.isHome) {
                                    setState(() {
                                      widget.isHome = true;
                                      selectedIndex = 0;
                                    });
                                    widget.scrollController.scrollToIndex(
                                      selectedIndex,
                                      preferPosition: AutoScrollPosition.middle,
                                    );
                                  } else {
                                    Get.toNamed("/?index=0");
                                  }
                                  break;
                                case 'Products':
                                  if (widget.isHome) {
                                    setState(() {
                                      widget.isHome = true;
                                      selectedIndex = 1;
                                    });
                                    widget.scrollController.scrollToIndex(
                                      selectedIndex,
                                      preferPosition: AutoScrollPosition.middle,
                                    );
                                  } else {
                                    Get.toNamed('/?index=1');
                                  }
                                  break;
                                case 'Order':
                                  if (widget.isHome) {
                                    setState(() {
                                      widget.isHome = true;
                                      selectedIndex = 2;
                                    });
                                    widget.scrollController.scrollToIndex(
                                      selectedIndex,
                                      preferPosition: AutoScrollPosition.middle,
                                    );
                                  } else {
                                    Get.toNamed('/?index=2');
                                  }
                                  break;
                                case 'Contact':
                                  int index = userController.login ? 3 : 2;
                                  if (widget.isHome) {
                                    setState(() {
                                      widget.isHome = true;
                                      selectedIndex = index;
                                    });
                                    widget.scrollController.scrollToIndex(
                                      index,
                                      preferPosition: AutoScrollPosition.middle,
                                    );
                                  } else {
                                    Get.toNamed('/?index=$index');
                                  }
                                  break;
                                default:
                                  Get.toNamed('/profile');
                              }
                            },
                            child: Text(e,
                                style: (userController.login ? menu : nav)
                                            .indexOf(e) ==
                                        selectedIndex
                                    ? whiteFontStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)
                                    : whiteFontStyle.copyWith(fontSize: 16)),
                          ),
                        ))
                    .toList(),
              ),
            ),
            userController.login
                ? SizedBox(width: 90)
                : Container(
                    width: 80,
                    height: 45,
                    margin: EdgeInsets.only(left: 10),
                    child: ElevatedButton(
                      style: mainButtonStyle,
                      child: Text('SIGN IN', style: whiteFontStyle),
                      onPressed: () => Get.toNamed('/signin'),
                    ),
                  ),
            Container(
              width: 80,
              height: 45,
              margin: EdgeInsets.only(left: 10),
              child: ElevatedButton(
                style: mainButtonStyle,
                child: Text(userController.login ? 'SIGN OUT' : 'SIGN UP',
                    style: whiteFontStyle),
                onPressed: () {
                  if (userController.login) {
                    userController.clear();
                    orderController.clear();
                    Get.toNamed('/');
                  } else {
                    Get.toNamed('/signup');
                  }
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
