import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:printing/models/models.dart';
import 'package:printing/utils/utils.dart';

part 'user_services.dart';
part 'product_services.dart';
part 'order_services.dart';
part 'profile_services.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference userRef = firestore.collection('Users');
final CollectionReference orderRef = firestore.collection('Orders');
final CollectionReference productRef = firestore.collection('Products');
final CollectionReference profileRef = firestore.collection('Profile');
