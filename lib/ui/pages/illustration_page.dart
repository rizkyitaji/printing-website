part of 'pages.dart';

class IllustrationPage extends StatelessWidget {
  final String text;

  IllustrationPage(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/undraw_not_found.svg',
              width: 200, height: 200),
          SizedBox(height: defMargin),
          Text(text, style: poppins.copyWith(fontSize: 18)),
        ],
      ),
    );
  }
}
