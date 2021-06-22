part of 'user.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = context.height / 2;
    var width = context.width / (Screen.small(context) ? 2 : 4);

    return Column(
      children: [
        SizedBox(height: defMargin),
        Container(
          width: double.infinity,
          color: Colors.white,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: defMargin),
          child: Text('Products', style: poppins.copyWith(fontSize: 18)),
        ),
        Padding(
          padding: EdgeInsets.all(defMargin),
          child: StreamBuilder<QuerySnapshot>(
            stream: productRef.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: Screen.small(context) ? 2 : 4,
                  crossAxisSpacing: defMargin,
                  mainAxisSpacing: defMargin,
                  childAspectRatio:
                      Screen.large(context) ? 1.2 : width / height,
                  children: snapshot.data.docs
                      .map((e) => InkWell(
                            onTap: () => Get.toNamed('/detail?detail=product',
                                arguments: Product.fromSnapshot(e)),
                            child: ProductCard(Product.fromSnapshot(e)),
                          ))
                      .toList(),
                );
              } else {
                return Center(
                  child: Text('No Products'),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
