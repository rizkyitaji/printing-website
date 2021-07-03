part of 'admin.dart';

class CompanyProfilePage extends StatefulWidget {
  @override
  _CompanyProfilePageState createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends State<CompanyProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController accountOwnerController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  bool invalidName = false;
  bool invalidDesc = false;
  bool invalidPhone = false;
  bool invalidEmail = false;
  bool invalidAddress = false;
  bool invalidAccountOwner = false;
  bool invalidAccountNumber = false;
  PickedFile imageFile;
  String picturePath;

  @override
  void initState() {
    super.initState();
    picturePath = profileController.profile.picturePath;
    nameController.text = profileController.profile.name;
    descController.text = profileController.profile.description;
    phoneController.text = profileController.profile.phone;
    emailController.text = profileController.profile.email;
    addressController.text = profileController.profile.address;
    accountOwnerController.text = profileController.profile.bankAccount.owner;
    accountNumberController.text = profileController.profile.bankAccount.number;
  }

  @override
  Widget build(BuildContext context) {
    return AdminPage(
      index: 0,
      isNotHome: true,
      child: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(Screen.isMobile(context) ? defMargin : 40),
            child: Row(
              children: [
                Icon(
                  Icons.admin_panel_settings,
                  size: Screen.isMobile(context) ? 22 : 40,
                  color: blue,
                ),
                SizedBox(width: 16),
                Text(
                  'Company Profile',
                  style: poppins.copyWith(
                    fontSize: Screen.isMobile(context) ? 14 : 28,
                    color: blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: defMargin),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(defMargin),
            child: content(context),
          ),
          SizedBox(height: defMargin),
        ],
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return picturePath != null
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black45),
            image: DecorationImage(
              image: NetworkImage(picturePath),
              fit: BoxFit.fill,
            ),
          )
        : BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black45),
          );
  }

  Widget content(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Screen.isMobile(context) ? double.infinity : 800,
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                imageFile =
                    await ImagePicker().getImage(source: ImageSource.gallery);

                if (imageFile != null) {
                  setState(() => picturePath = imageFile.path);
                }
              },
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: boxDecoration(),
                child: picturePath == null
                    ? Icon(Icons.add_circle, size: 60, color: grey)
                    : SizedBox(),
              ),
            ),
            SizedBox(height: defMargin),
            CustomForm(
              field: 'Name',
              child: CustomTextField(
                marginLeft: 16,
                controller: nameController,
                caps: TextCapitalization.words,
                hintText: "Type your company name",
                validator: invalidName,
              ),
            ),
            SizedBox(height: 16),
            CustomForm(
              field: 'Description',
              child: CustomTextField(
                marginLeft: 16,
                maxLines: 5,
                controller: descController,
                type: TextInputType.multiline,
                caps: TextCapitalization.sentences,
                hintText: "Type your company description",
                validator: invalidDesc,
              ),
            ),
            SizedBox(height: 16),
            CustomForm(
              field: 'Phone No.',
              child: CustomTextField(
                marginLeft: 16,
                controller: phoneController,
                type: TextInputType.number,
                hintText: "Type your company's phone number",
                validator: invalidPhone,
              ),
            ),
            SizedBox(height: 16),
            CustomForm(
              field: 'Email',
              child: CustomTextField(
                marginLeft: 16,
                controller: emailController,
                type: TextInputType.emailAddress,
                hintText: "Type your company email",
                validator: invalidEmail,
                email: true,
              ),
            ),
            SizedBox(height: 16),
            CustomForm(
              field: 'Address',
              child: CustomTextField(
                marginLeft: 16,
                controller: addressController,
                caps: TextCapitalization.words,
                hintText: "Type your company address",
                validator: invalidAddress,
              ),
            ),
            SizedBox(height: 16),
            CustomForm(
              field: 'Bank Account Owner',
              child: CustomTextField(
                marginLeft: 16,
                controller: accountOwnerController,
                caps: TextCapitalization.words,
                hintText: "Type your bank account owner",
                validator: invalidAccountOwner,
              ),
            ),
            SizedBox(height: 16),
            CustomForm(
              field: 'Bank Account Number',
              child: CustomTextField(
                marginLeft: 16,
                controller: accountNumberController,
                caps: TextCapitalization.words,
                type: TextInputType.number,
                hintText: "Type your bank account number",
                validator: invalidAccountNumber,
              ),
            ),
            Container(
              width: 150,
              height: 45,
              margin: EdgeInsets.symmetric(vertical: defMargin),
              child: ElevatedButton(
                style: mainButtonStyle,
                child: Text('UPDATE'),
                onPressed: () async {
                  if (nameController.text.isEmpty) {
                    setState(() => invalidName = true);
                  } else if (descController.text.isEmpty) {
                    setState(() => invalidDesc = true);
                  } else if (phoneController.text.isEmpty) {
                    setState(() => invalidPhone = true);
                  } else if (emailController.text.isEmpty ||
                      !emailController.text.contains('@')) {
                    setState(() => invalidEmail = true);
                  } else if (addressController.text.isEmpty) {
                    setState(() => invalidAddress = true);
                  } else if (accountOwnerController.text.isEmpty) {
                    setState(() => invalidAccountOwner = true);
                  } else if (accountNumberController.text.isEmpty) {
                    setState(() => invalidAccountNumber = true);
                  } else if (Check.isNumeric(phoneController.text) ||
                      Check.isNumeric(accountNumberController.text)) {
                    Toast.show('Please input numbers only!', context);
                  } else {
                    updateProfile();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateProfile() async {
    bool result = await profileController.updateProfile(
      Profile(
        name: nameController.text,
        description: descController.text,
        picturePath: picturePath,
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        address: addressController.text,
        bankAccount: BankAccount(
          owner: accountOwnerController.text,
          number: accountNumberController.text.trim(),
        ),
      ),
      file: imageFile,
    );

    String msg = profileController.message;

    if (result) {
      Toast.show(msg, context, backgroundColor: green, duration: 2);
    } else {
      Toast.show(msg, context, backgroundColor: red, duration: 2);
    }
  }
}
