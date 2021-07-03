part of 'user.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  CarouselController controller = CarouselController();
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Screen.small(context) ? defMargin : 100,
        vertical: 40,
      ),
      child: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (state) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 24),
                    child: IconButton(
                      onPressed: () => controller.previousPage(),
                      icon: Icon(
                        Icons.arrow_left,
                        color: blue,
                        size: 50,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Screen.small(context)
                        ? context.width - 172
                        : context.width - 304,
                    child: CarouselSlider(
                      carouselController: controller,
                      options: CarouselOptions(
                        height: Screen.small(context) ? 250 : 400,
                        initialPage: 0,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          setState(() => current = index);
                        },
                      ),
                      items: state.pictures
                          .map((e) => Container(
                                width: double.infinity,
                                child: Image.network(
                                  e.path,
                                  fit: BoxFit.fill,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: () => controller.nextPage(),
                      icon: Icon(
                        Icons.arrow_right,
                        color: blue,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: state.pictures.map((e) {
                  int index = state.pictures.indexOf(e);
                  double size = Screen.small(context) ? 30 : 40;
                  return InkWell(
                    onTap: () => controller.jumpToPage(index),
                    child: Container(
                      width: size,
                      height: size,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: index == current ? darkBlue : Colors.white),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(e.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}
