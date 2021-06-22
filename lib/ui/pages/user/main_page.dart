part of 'user.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final scrollDirection = Axis.vertical;
  AutoScrollController scrollController;
  int index =
      Get.parameters['index'] == null ? 0 : int.parse(Get.parameters['index']);

  @override
  void initState() {
    super.initState();
    profileController.getProfile();
    productController.getProducts();
    scrollController = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, 0),
      axis: scrollDirection,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GeneralPage(
        isHome: true,
        index: index,
        scrollController: scrollController,
        child: Obx(() {
          return ListView(
            scrollDirection: scrollDirection,
            controller: scrollController,
            children: [
              SizedBox(height: Screen.small(context) ? 0 : 80),
              ...List.generate(userController.login ? 5 : 4, (index) {
                return AutoScrollTag(
                  key: ValueKey(index),
                  index: index,
                  controller: scrollController,
                  child: index == 0
                      ? SliderPage()
                      : index == 1
                          ? ProductPage()
                          : userController.login
                              ? (index == 2
                                  ? OrderPage()
                                  : index == 3
                                      ? AboutUsPage()
                                      : ContactPage())
                              : (index == 2 ? AboutUsPage() : ContactPage()),
                );
              }),
              Footer()
            ],
          );
        }),
      ),
    );
  }
}
