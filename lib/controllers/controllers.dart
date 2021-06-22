import 'dart:math';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:printing/models/models.dart';
import 'package:printing/services/services.dart';
import 'package:printing/utils/utils.dart';

part 'user_controller.dart';
part 'product_controller.dart';
part 'order_controller.dart';
part 'profile_controller.dart';

UserController userController = Get.put(UserController());
OrderController orderController = Get.put(OrderController());
ProductController productController = Get.put(ProductController());
ProfileController profileController = Get.put(ProfileController());
