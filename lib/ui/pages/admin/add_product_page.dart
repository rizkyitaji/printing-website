part of 'admin.dart';

enum Variant { color, size }

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController variant1Controller = TextEditingController();
  TextEditingController variant2Controller = TextEditingController();
  TextEditingController variant3Controller = TextEditingController();
  Variant _variant = Variant.color;
  bool invalidName = false;
  PickedFile imageFile;
  String picturePath;
  List<String> variants;

  List<String> colorVariant = [
    '2 colors',
    '3 or 4 colors',
    'More than 4 colors',
  ];
  List<String> sizeVariant = [
    '15 x 15 cm',
    '15 x 15 cm',
    '15 x 15 cm',
  ];

  @override
  void initState() {
    super.initState();
    variants = colorVariant;
  }

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
                      } else if (variant1Controller.text.isEmpty ||
                          variant2Controller.text.isEmpty ||
                          variant3Controller.text.isEmpty ||
                          picturePath == null) {
                        Toast.show('Please fill in all of the fields', context);
                      } else if (!Check.isAlphanumeric(
                              variant1Controller.text) ||
                          !Check.isAlphanumeric(variant2Controller.text) ||
                          !Check.isAlphanumeric(variant3Controller.text)) {
                        Toast.show(
                            'Variant price must contain only number', context);
                      } else {
                        bool result = await productController.addProduct(
                          Product(
                            name: nameController.text,
                            options: [
                              Option(
                                id: 1,
                                variant: variants[0],
                                price:
                                    int.parse(variant1Controller.text.trim()),
                              ),
                              Option(
                                id: 2,
                                variant: variants[1],
                                price:
                                    int.parse(variant2Controller.text.trim()),
                              ),
                              Option(
                                id: 3,
                                variant: variants[2],
                                price:
                                    int.parse(variant3Controller.text.trim()),
                              ),
                            ],
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
            CustomForm(
              field: 'Name',
              child: CustomTextField(
                marginLeft: 16,
                controller: nameController,
                action: TextInputAction.done,
                caps: TextCapitalization.words,
                hintText: "Type your product's name",
                validator: invalidName,
              ),
            ),
            SizedBox(height: 12),
            CustomForm(
              field: 'Variant',
              children: [
                SizedBox(width: 16),
                Expanded(
                  child: ListTile(
                    leading: Radio<Variant>(
                      value: Variant.color,
                      groupValue: _variant,
                      onChanged: (value) {
                        _variant = value;
                        variants = colorVariant;
                        setState(() {});
                      },
                    ),
                    title: Text('Color', style: poppins),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: Radio<Variant>(
                      value: Variant.size,
                      groupValue: _variant,
                      onChanged: (value) {
                        _variant = value;
                        variants = sizeVariant;
                        setState(() {});
                      },
                    ),
                    title: Text('Size', style: poppins),
                  ),
                ),
              ],
            ),
            SizedBox(height: defMargin),
            CustomForm(field: "Variant Price"),
            variant(
              value: variants[0],
              child: CustomTextField(
                marginLeft: 16,
                controller: variant1Controller,
                type: TextInputType.number,
                hintText: 'Type your first variant price',
              ),
            ),
            SizedBox(height: 12),
            variant(
              value: variants[1],
              child: CustomTextField(
                marginLeft: 16,
                controller: variant2Controller,
                type: TextInputType.number,
                hintText: 'Type your second variant price',
              ),
            ),
            SizedBox(height: 12),
            variant(
              value: variants[2],
              child: CustomTextField(
                marginLeft: 16,
                controller: variant3Controller,
                type: TextInputType.number,
                hintText: 'Type your third variant price',
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget variant({String value, Widget child}) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18),
          child: Icon(
            Icons.lens,
            size: 16,
            color: darkBlue,
          ),
        ),
        Expanded(
          child: CustomForm(
            field: value,
            child: child,
          ),
        ),
      ],
    );
  }
}
