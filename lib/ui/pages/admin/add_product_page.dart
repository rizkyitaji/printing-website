part of 'admin.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController price1Controller = TextEditingController();
  TextEditingController price2Controller = TextEditingController();
  bool invalidName = false;
  bool invalidDesc = false;
  PickedFile imageFile;
  String picturePath;

  @override
  Widget build(BuildContext context) {
    return AdminPage(
      index: 2,
      isNotHome: true,
      child: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(Screen.isMobile(context) ? defMargin : 40),
            child: Row(
              children: [
                Icon(
                  Icons.view_list,
                  size: Screen.isMobile(context) ? 22 : 40,
                  color: blue,
                ),
                SizedBox(width: 16),
                Text(
                  'Add Products',
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
            padding: EdgeInsets.all(40),
            child: Column(
              children: [
                Screen.small(context)
                    ? Column(children: content(context))
                    : Row(children: content(context)),
                SizedBox(height: 40),
                Container(
                  width: 200,
                  height: 45,
                  margin: EdgeInsets.symmetric(vertical: defMargin),
                  child: ElevatedButton(
                    style: mainButtonStyle,
                    child: Text('SUBMIT'),
                    onPressed: () async {
                      if (nameController.text.isEmpty) {
                        setState(() => invalidName = true);
                      } else if (descController.text.isEmpty) {
                        setState(() => invalidDesc = true);
                      } else if (price1Controller.text.isEmpty ||
                          price2Controller.text.isEmpty) {
                        Toast.show('Please fill in all of the fields', context);
                      } else if (picturePath == null) {
                        Toast.show('Please fill in all of the fields', context);
                      } else {
                        bool result = await productController.addProduct(
                          Product(
                            name: nameController.text,
                            // description: descController.text,
                            // price1: int.parse(price1Controller.text),
                            // price2: int.parse(price2Controller.text),
                          ),
                          imageFile,
                        );

                        String msg = productController.message;

                        if (result != null) {
                          Toast.show(msg, context,
                              backgroundColor: green, duration: 2);
                          Get.toNamed('/admin', arguments: 2);
                        } else {
                          Toast.show(msg, context,
                              backgroundColor: red, duration: 2);
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return picturePath != null
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black),
            image: DecorationImage(
              image: NetworkImage(picturePath),
              fit: BoxFit.fill,
            ),
          )
        : BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black),
          );
  }

  List<Widget> content(BuildContext context) {
    return [
      InkWell(
        onTap: () async {
          imageFile = await ImagePicker().getImage(source: ImageSource.gallery);

          if (imageFile != null) {
            setState(() => picturePath = imageFile.path);
          }
        },
        child: Container(
          width: Screen.small(context) ? double.infinity : 200,
          height: 200,
          decoration: boxDecoration(),
          child: picturePath == null
              ? Icon(Icons.add_circle, size: 60, color: grey)
              : SizedBox(),
        ),
      ),
      SizedBox(width: 40, height: 40),
      SizedBox(
        width: Screen.small(context) ? double.infinity : context.width - 410,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text('Name', style: poppins),
                ),
                SizedBox(width: 12),
                colon,
                SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    controller: nameController,
                    caps: TextCapitalization.words,
                    hintText: "Type your product's name",
                    validator: invalidName,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Text('Description', style: poppins),
                ),
                SizedBox(width: 12),
                colon,
                SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    maxLines: 5,
                    controller: descController,
                    action: TextInputAction.next,
                    type: TextInputType.multiline,
                    caps: TextCapitalization.sentences,
                    hintText: "Type your product's description",
                    validator: invalidDesc,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text('Price', style: poppins),
                ),
                SizedBox(width: 12),
                colon,
                SizedBox(width: 12),
                CustomTextField(
                  width: 100,
                  marginRight: 12,
                  controller: price1Controller,
                  action: TextInputAction.next,
                  type: TextInputType.number,
                  hintText: "0",
                ),
                Text('-', style: poppins),
                CustomTextField(
                  width: 100,
                  marginLeft: 12,
                  controller: price2Controller,
                  action: TextInputAction.done,
                  type: TextInputType.number,
                  hintText: "0",
                ),
              ],
            ),
          ],
        ),
      ),
    ];
  }
}
