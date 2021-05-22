part of 'shared.dart';

const double defMargin = 24;

Color blue = Colors.blue;
Color darkBlue = Colors.blue[800];
Color grey = '8D92A3'.toColor();
Color green = '1ABC9C'.toColor();
Color red = 'D9435E'.toColor();

String lorem =
    "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

TextStyle poppins = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);

TextStyle whiteFontStyle = GoogleFonts.poppins()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);

TextStyle statusFontStyle = GoogleFonts.poppins().copyWith(fontSize: 11);

ButtonStyle mainButtonStyle = ElevatedButton.styleFrom(
  primary: darkBlue,
  elevation: 0,
  onPrimary: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);

ButtonStyle whiteButtonStyle = ElevatedButton.styleFrom(
  primary: Colors.white,
  elevation: 0,
  onPrimary: darkBlue,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
    side: BorderSide(color: darkBlue),
  ),
);

Widget colon = Text(':', style: poppins);

Widget footerSection = Container(
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
