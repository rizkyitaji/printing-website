part of 'pages.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController emailController =
      TextEditingController(text: profileController.profile.email);
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController textController = TextEditingController();
  bool invalidEmail = false;
  bool invalidSubject = false;
  bool invalidBody = false;
  bool invalidText = false;
  bool selected = false;

  double screenWidth({double min}) {
    return min == null ? Get.width : context.width - min;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: defMargin),
        Container(
          width: double.infinity,
          color: Colors.white,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: defMargin),
          child: Text('Contact', style: poppins.copyWith(fontSize: 18)),
        ),
        SizedBox(height: 3),
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: defMargin,
            horizontal: Screen.small(context) ? defMargin : 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Send us message via :',
                style: poppins.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: defMargin),
              Stack(
                children: [
                  Screen.small(context)
                      ? Column(children: contact(context))
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: contact(context),
                        ),
                  Screen.small(context)
                      ? Row(children: divider(context))
                      : Column(children: divider(context)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> divider(BuildContext context) {
    return [
      Container(
        width: Screen.small(context) ? 198 : 3,
        height: Screen.small(context) ? 3 : 148,
        color: selected ? null : Colors.white,
        margin: EdgeInsets.only(
          top: Screen.small(context) ? 149 : 1,
          left: Screen.small(context) ? 1 : 198,
        ),
      ),
      SizedBox(
        width: Screen.small(context) ? screenWidth(min: 448) : 0,
      ),
      Container(
        width: Screen.small(context) ? 198 : 3,
        height: Screen.small(context) ? 3 : 148,
        color: selected ? Colors.white : null,
        margin: EdgeInsets.only(
          top: Screen.small(context) ? 149 : 74,
          left: Screen.small(context) ? 2 : 198,
        ),
      ),
    ];
  }

  List<Widget> contact(BuildContext context) {
    return [
      Screen.small(context)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: contactIcon(),
            )
          : Column(children: contactIcon()),
      Container(
        width: Screen.small(context) ? double.infinity : screenWidth(min: 280),
        height: Screen.small(context) ? null : (selected ? 372 : null),
        padding: EdgeInsets.all(defMargin),
        decoration: BoxDecoration(
          border: Border.all(color: blue),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(selected ? 10 : 0),
            topRight: Radius.circular(
                Screen.small(context) ? (selected ? 0 : 10) : 10),
            bottomLeft: Radius.circular(
                selected ? (Screen.small(context) ? 10 : 0) : 10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: selected ? contactWhatsapp(context) : contactEmail(context),
      ),
    ];
  }

  List<Widget> contactIcon() {
    return [
      Container(
        width: 200,
        height: 150,
        margin: EdgeInsets.only(
          bottom: Screen.small(context) ? 0 : defMargin,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? Colors.white : blue,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(Screen.small(context) ? 10 : 0),
            bottomLeft: Radius.circular(Screen.small(context) ? 0 : 10),
          ),
        ),
        child: InkWell(
          onTap: () => setState(() => selected = false),
          child: Image.asset(
            'assets/gmail.png',
            width: 100,
            height: 100,
          ),
        ),
      ),
      Text(
        'OR',
        style: poppins.copyWith(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      Container(
        width: 200,
        height: 150,
        margin: EdgeInsets.symmetric(
          vertical: Screen.small(context) ? 0 : defMargin,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? blue : Colors.white,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(Screen.small(context) ? 10 : 0),
            bottomLeft: Radius.circular(Screen.small(context) ? 0 : 10),
          ),
        ),
        child: InkWell(
          onTap: () => setState(() => selected = true),
          child: Image.asset(
            'assets/whatsapp.png',
            width: 100,
            height: 100,
          ),
        ),
      ),
    ];
  }

  Widget contactEmail(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            attributeContact('To'),
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
        SizedBox(height: 12),
        Row(
          children: [
            attributeContact('Subject'),
            colon,
            Expanded(
              child: CustomTextField(
                marginLeft: 12,
                controller: subjectController,
                action: TextInputAction.next,
                caps: TextCapitalization.words,
                hintText: 'Type your email subject',
                validator: invalidSubject,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(children: [attributeContact('Message'), colon]),
        SizedBox(height: 12),
        CustomTextField(
          controller: bodyController,
          caps: TextCapitalization.sentences,
          type: TextInputType.multiline,
          maxLines: 5,
          hintText: 'Type your message',
          validator: invalidBody,
        ),
        SizedBox(height: defMargin),
        Container(
          width: 200,
          height: 45,
          child: ElevatedButton(
            style: mainButtonStyle,
            child: Text('Send Message'),
            onPressed: () async {
              if (emailController.text.isEmpty ||
                  !emailController.text.contains('@')) {
                setState(() => invalidEmail = true);
              } else if (subjectController.text.isEmpty) {
                setState(() => invalidSubject = true);
              } else if (bodyController.text.isEmpty) {
                setState(() => invalidBody = true);
              } else {
                await launch(
                  'mailto: ${emailController.text}?subject=${subjectController.text}&body=${bodyController.text}',
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget contactWhatsapp(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            attributeContact('To'),
            colon,
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 12),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Obx(() {
                  return Text(
                    profileController.profile.phone,
                    style: poppins.copyWith(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
        SizedBox(height: defMargin),
        Row(children: [attributeContact('Message'), colon]),
        SizedBox(height: defMargin),
        CustomTextField(
          controller: textController,
          action: TextInputAction.done,
          caps: TextCapitalization.sentences,
          type: TextInputType.multiline,
          maxLines: 5,
          hintText: 'Type your message',
          validator: invalidText,
        ),
        SizedBox(height: defMargin),
        Screen.small(context)
            ? Column(children: btnWhatsapp())
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: btnWhatsapp(),
              ),
      ],
    );
  }

  List<Widget> btnWhatsapp() {
    String phone = '62${profileController.profile.phone.substring(1)}';
    return [
      Container(
        width: 200,
        height: 45,
        child: ElevatedButton(
          style: mainButtonStyle,
          child: Text('Send Message'),
          onPressed: () async {
            if (textController.text.isEmpty) {
              setState(() => invalidText = true);
            } else {
              await launch(
                "https://api.whatsapp.com/send/?phone=$phone&text=${textController.text}",
              );
            }
          },
        ),
      ),
      SizedBox(width: 12, height: 12),
      Container(
        width: 200,
        height: 45,
        child: ElevatedButton(
          style: whiteButtonStyle,
          child: Text('Chat us on Whatsapp'),
          onPressed: () async {
            await launch(
              "https://api.whatsapp.com/send/?phone=$phone",
            );
          },
        ),
      ),
    ];
  }

  Widget attributeContact(String text) {
    return Container(
      width: 65,
      margin: EdgeInsets.only(right: 12),
      child: Text(
        text,
        style: poppins,
      ),
    );
  }
}
