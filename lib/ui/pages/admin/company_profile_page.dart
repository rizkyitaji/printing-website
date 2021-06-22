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
  bool invalidName = false;
  bool invalidDesc = false;
  bool invalidPhone = false;
  bool invalidEmail = false;
  bool invalidAddress = false;
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
              child: picturePath == null
                  ? Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: Colors.black45),
                      ),
                      child: Icon(Icons.add_circle, size: 60, color: grey),
                    )
                  : Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: Colors.black45),
                        image: DecorationImage(
                          image: NetworkImage(picturePath),
                        ),
                      ),
                    ),
            ),
            SizedBox(height: defMargin),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text('Name', style: poppins),
                ),
                SizedBox(width: 12),
                colon,
                Expanded(
                  child: CustomTextField(
                    marginLeft: 16,
                    controller: nameController,
                    action: TextInputAction.next,
                    caps: TextCapitalization.words,
                    hintText: "Type your company name",
                    validator: invalidName,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  margin: EdgeInsets.only(top: 4),
                  child: Text('Description', style: poppins),
                ),
                SizedBox(width: 12),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  child: colon,
                ),
                Expanded(
                  child: CustomTextField(
                    marginLeft: 16,
                    maxLines: 5,
                    controller: descController,
                    action: TextInputAction.next,
                    type: TextInputType.multiline,
                    caps: TextCapitalization.sentences,
                    hintText: "Type your company description",
                    validator: invalidDesc,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text('Phone No.', style: poppins),
                ),
                SizedBox(width: 12),
                colon,
                Expanded(
                  child: CustomTextField(
                    marginLeft: 16,
                    controller: phoneController,
                    action: TextInputAction.next,
                    type: TextInputType.number,
                    hintText: "Type your company's phone number",
                    validator: invalidPhone,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text('Email', style: poppins),
                ),
                SizedBox(width: 12),
                colon,
                Expanded(
                  child: CustomTextField(
                    marginLeft: 16,
                    controller: emailController,
                    action: TextInputAction.next,
                    type: TextInputType.emailAddress,
                    hintText: "Type your company email",
                    validator: invalidEmail,
                    email: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text('Address', style: poppins),
                ),
                SizedBox(width: 12),
                colon,
                Expanded(
                  child: CustomTextField(
                    marginLeft: 16,
                    controller: addressController,
                    action: TextInputAction.next,
                    caps: TextCapitalization.words,
                    hintText: "Type your company address",
                    validator: invalidAddress,
                  ),
                ),
              ],
            ),
            Container(
              width: 150,
              height: 45,
              margin: EdgeInsets.symmetric(vertical: defMargin),
              child: ElevatedButton(
                style: mainButtonStyle,
                child: Text('UPDATE'),
                onPressed: () async {
                  bool result = await profileController.updateProfile(
                    Profile(
                      name: nameController.text,
                      description: descController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                      address: addressController.text,
                    ),
                    file: imageFile,
                  );

                  String msg = profileController.message;

                  if (result) {
                    Toast.show(msg, context,
                        backgroundColor: green, duration: 2);
                  } else {
                    Toast.show(msg, context, backgroundColor: red, duration: 2);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
