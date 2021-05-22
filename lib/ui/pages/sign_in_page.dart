part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool invalidEmail = false;
  bool invalidPass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Container(
            width: Screen.small(context) ? double.infinity : 400,
            height: 520,
            margin: EdgeInsets.all(defMargin),
            padding: EdgeInsets.all(defMargin),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_circle, size: 150),
                SizedBox(height: defMargin),
                CustomTextField(
                  controller: emailController,
                  action: TextInputAction.next,
                  type: TextInputType.emailAddress,
                  hintText: 'Type your email address',
                  validator: invalidEmail,
                  email: true,
                ),
                CustomTextField(
                  marginTop: 16,
                  controller: passController,
                  action: TextInputAction.done,
                  hintText: 'Type your password',
                  validator: invalidPass,
                  obscureText: true,
                  password: true,
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  margin: EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    style: mainButtonStyle,
                    child: Text('Sign In', style: whiteFontStyle),
                    onPressed: () async {
                      if (emailController.text.isEmpty ||
                          !emailController.text.contains('@')) {
                        setState(() => invalidEmail = true);
                      } else if (passController.text.isEmpty ||
                          passController.text.length < 8) {
                        setState(() => invalidPass = true);
                      } else {
                        bool result = await userController.signIn(
                          emailController.text.trim(),
                          passController.text.trim(),
                        );

                        String msg = userController.message;

                        if (result) {
                          Toast.show(msg, context,
                              backgroundColor: green, duration: 2);
                          userController.user.level.compareTo('admin') == 0
                              ? Get.offNamed('/admin')
                              : Get.toNamed('/');
                        } else {
                          Toast.show(msg, context,
                              backgroundColor: red, duration: 2);
                        }
                      }
                    },
                  ),
                ),
                SizedBox(height: defMargin),
                Row(
                  children: [
                    Text("Don't have an account?", style: poppins),
                    SizedBox(width: 8),
                    TextButton(
                      onPressed: () => Get.toNamed('/signup'),
                      child: Text(
                        'Sign Up Now',
                        style: poppins.copyWith(color: darkBlue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
