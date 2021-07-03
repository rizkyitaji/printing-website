part of 'user.dart';

class AboutUsPage extends StatelessWidget {
  final List<String> image = [
    'client1.jpg',
    'client2.jpg',
    'client3.jpg',
    'client4.jpg',
    'client5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: userController.login ? defMargin : 0),
        Container(
          width: double.infinity,
          color: Colors.white,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: defMargin),
          child: Text('About Us', style: poppins.copyWith(fontSize: 18)),
        ),
        SizedBox(height: 3),
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.all(40),
          child: Column(
            children: [
              Text(
                '${profileController.profile.description}',
                style: poppins,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Text('Our Clients :', style: poppins.copyWith(fontSize: 16)),
              SizedBox(height: defMargin),
              Wrap(
                spacing: defMargin,
                runSpacing: defMargin,
                children: image
                    .map((e) => Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 5, color: darkBlue),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1, color: darkBlue),
                              image: DecorationImage(
                                image: AssetImage('assets/$e'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
