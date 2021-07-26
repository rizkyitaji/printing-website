part of 'user.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final searchController = TextEditingController();
  bool isNotEmpty = false;

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
        SizedBox(height: defMargin),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: Screen.isMobile(context) ? defMargin : 100),
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search',
              contentPadding: EdgeInsets.fromLTRB(0, 10, 10, 10),
              suffixIcon: InkWell(
                onTap: () {
                  searchController.text = '';
                  setState(() => isNotEmpty = false);
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Icon(isNotEmpty ? Icons.close : Icons.search),
              ),
              suffixIconConstraints: BoxConstraints(),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                isNotEmpty = true;
              } else {
                isNotEmpty = false;
              }
              setState(() {});
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(defMargin),
          child: StreamBuilder<QuerySnapshot>(
            stream: productRef.snapshots(),
            builder: (context, snapshot) {
              var query = snapshot.data.docs.where((element) {
                return element
                    .data()['name']
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase());
              }).toList();

              if (snapshot.hasData) {
                return GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: Screen.small(context) ? 2 : 4,
                  crossAxisSpacing: defMargin,
                  mainAxisSpacing: defMargin,
                  childAspectRatio:
                      Screen.large(context) ? 1.2 : width / height,
                  children: (isNotEmpty ? query : snapshot.data.docs)
                      .map((e) => InkWell(
                            onTap: () => Get.toNamed('/detail?detail=product',
                                arguments: Product.fromSnapshot(e)),
                            child: ProductCard(Product.fromSnapshot(e)),
                          ))
                      .toList(),
                );
              } else {
                return Center(
                  child: IllustrationPage('No Products'),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
