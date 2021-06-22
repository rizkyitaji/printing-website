part of 'admin.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  TextEditingController searchController = TextEditingController();
  bool isNotEmpty = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                'Products',
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
        // search
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
                  productController.getProducts();
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
                productController.search(searchController.text);
                setState(() => isNotEmpty = true);
              } else {
                productController.getProducts();
                setState(() => isNotEmpty = false);
              }
            },
          ),
        ),
        // list
        Container(
          margin: EdgeInsets.all(Screen.isMobile(context) ? defMargin : 40),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: GetBuilder<ProductController>(
            init: ProductController(),
            builder: (state) {
              if (state.products.length != 0) {
                return Column(
                  children: state.products
                      .map((e) => Padding(
                            padding: EdgeInsets.only(
                              bottom: e == state.products.last ? 0 : defMargin,
                            ),
                            child: InkWell(
                              onTap: () =>
                                  Get.toNamed('/detailProduct', arguments: e),
                              child: ProductListItem(e),
                            ),
                          ))
                      .toList(),
                );
              } else {
                return isNotEmpty
                    ? IllustrationPage('Product not found')
                    : IllustrationPage('No products');
              }
            },
          ),
        ),
      ],
    );
  }
}
