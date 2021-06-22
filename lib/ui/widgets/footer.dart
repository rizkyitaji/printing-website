part of 'widgets.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 74,
      color: blue,
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Obx(() {
            return Text(
              '${profileController.profile.name}  -  ' +
                  DateTime.now().year.toString(),
              style: whiteFontStyle,
            );
          }),
          SizedBox(height: 8),
          Obx(() {
            return Text(
              profileController.profile.address,
              style: whiteFontStyle,
            );
          }),
        ],
      ),
    );
  }
}
