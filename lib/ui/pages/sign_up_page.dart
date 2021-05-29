part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool invalidName = false;
  bool invalidEmail = false;
  bool invalidPass = false;
  bool invalidPhone = false;
  bool invalidAddress = false;
  List<String> cities;
  String selectedCity;

  @override
  void initState() {
    super.initState();
    cities = ['Select your city', 'Jakarta', 'Bandung', 'Surabaya'];
    selectedCity = cities[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Container(
                width: context.isPhone ? double.infinity : 800,
                margin: EdgeInsets.all(defMargin),
                padding: EdgeInsets.all(defMargin),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Icon(Icons.account_circle, size: 150),
                    SizedBox(height: defMargin),
                    Row(
                      children: [
                        attribute('Full Name'),
                        colon,
                        Expanded(
                          child: CustomTextField(
                            marginLeft: 12,
                            controller: nameController,
                            action: TextInputAction.next,
                            hintText: 'Type your full name',
                            validator: invalidName,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        attribute('Email Address'),
                        colon,
                        Expanded(
                          child: CustomTextField(
                            marginLeft: 12,
                            controller: emailController,
                            action: TextInputAction.next,
                            type: TextInputType.emailAddress,
                            hintText: 'Type your email address',
                            validator: invalidEmail,
                            email: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        attribute('Password'),
                        colon,
                        Expanded(
                          child: CustomTextField(
                            marginLeft: 12,
                            controller: passController,
                            action: TextInputAction.next,
                            hintText: 'Type your password',
                            validator: invalidPass,
                            obscureText: true,
                            password: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        attribute('Phone Number'),
                        colon,
                        Expanded(
                          child: CustomTextField(
                            marginLeft: 12,
                            controller: phoneController,
                            action: TextInputAction.next,
                            type: TextInputType.number,
                            hintText: 'Type your phone number',
                            validator: invalidPhone,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        attribute('Address'),
                        colon,
                        Expanded(
                          child: CustomTextField(
                            marginLeft: 12,
                            controller: addressController,
                            action: TextInputAction.done,
                            caps: TextCapitalization.words,
                            hintText: 'Type your address',
                            validator: invalidAddress,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        attribute('City'),
                        colon,
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 12),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButton<dynamic>(
                              value: selectedCity,
                              isExpanded: true,
                              dropdownColor: Colors.lightBlue[50],
                              underline: SizedBox(),
                              items: cities
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e,
                                            style:
                                                (e.contains('Select your city'))
                                                    ? poppins.copyWith(
                                                        color: grey,
                                                        fontSize: 12)
                                                    : poppins.copyWith(
                                                        fontSize: 12)),
                                      ))
                                  .toList(),
                              onChanged: (item) {
                                setState(() => selectedCity = item);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 45,
                      margin: EdgeInsets.only(top: defMargin),
                      child: ElevatedButton(
                        style: mainButtonStyle,
                        child: Text('Sign Up', style: whiteFontStyle),
                        onPressed: () async {
                          if (nameController.text.isEmpty) {
                            setState(() => invalidName = true);
                          } else if (emailController.text.isEmpty ||
                              !emailController.text.contains('@')) {
                            setState(() => invalidEmail = true);
                          } else if (passController.text.isEmpty ||
                              passController.text.length < 8) {
                            setState(() => invalidPass = true);
                          } else if (phoneController.text.isEmpty) {
                            setState(() => invalidPhone = true);
                          } else if (addressController.text.isEmpty) {
                            setState(() => invalidAddress = true);
                          } else if (selectedCity == 'Select your city') {
                            Toast.show('You have to fill in all of the fields',
                                context,
                                backgroundColor: red, duration: 2);
                          } else {
                            bool result = await userController.signUp(
                              User(
                                id: emailController.text.trim(),
                                name: nameController.text,
                                email: emailController.text.trim(),
                                password: passController.text.trim(),
                                phone: phoneController.text.trim(),
                                address: addressController.text,
                                city: selectedCity,
                                level: 'user',
                              ),
                            );

                            String msg = userController.message;

                            if (result) {
                              Toast.show(msg, context,
                                  backgroundColor: green, duration: 2);
                              Get.toNamed('/');
                            } else {
                              Toast.show(msg, context,
                                  backgroundColor: red, duration: 2);
                            }
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: defMargin),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account?', style: poppins),
                          SizedBox(width: 8),
                          TextButton(
                            onPressed: () => Get.toNamed('/signin'),
                            child: Text(
                              'Sign In',
                              style: poppins.copyWith(color: darkBlue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget attribute(String text) {
    return Container(
      width: 105,
      margin: EdgeInsets.only(right: 12),
      child: Text(text, style: poppins),
    );
  }
}
