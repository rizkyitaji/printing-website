part of 'widgets.dart';

class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final List<String> titles;
  final Function(int) onTap;

  CustomTabBar({
    this.titles,
    this.selectedIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 48),
            height: 1,
            color: Colors.grey[100],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: titles
                .map(
                  (e) => Container(
                    width: (MediaQuery.of(context).size.width / titles.length) -
                        80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            if (onTap != null) {
                              onTap(titles.indexOf(e));
                            }
                          },
                          child: Text(e,
                              style: (titles.indexOf(e) == selectedIndex)
                                  ? poppins
                                  : poppins.copyWith(color: grey)),
                        ),
                        Container(
                          width: 40,
                          height: 3,
                          margin: EdgeInsets.only(top: 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.5),
                            color: (titles.indexOf(e) == selectedIndex)
                                ? '020202'.toColor()
                                : Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
