import 'dart:async';
import 'dart:convert';
import 'dart:io';

import "package:async/async.dart";
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/models/addressModel.dart';
import 'package:zwerge/models/announcmentModel.dart';
import 'package:zwerge/models/areaModel.dart';
import 'package:zwerge/models/cartUpdateModel.dart';
import 'package:zwerge/models/discountsModel.dart';
import 'package:zwerge/models/loginModel.dart';
import 'package:zwerge/models/ordersModel.dart';
import 'package:zwerge/models/ratingsModel.dart';
import 'package:zwerge/models/shopContactModel.dart';
import 'package:zwerge/models/staticPagesModel.dart';
import 'package:zwerge/models/supportsModel.dart';
import 'package:zwerge/screens/address.dart';
import 'package:zwerge/screens/customerSupport.dart';
import 'package:zwerge/screens/home.dart';
import 'package:zwerge/screens/infoSlider.dart';
import 'package:zwerge/screens/signIn.dart';
import 'package:zwerge/services/remote_services.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/utils/helper.dart';

class UserController extends GetxController {
  bool? isLogin = false;
  var areas;
  ShopCotactModel? shopContact;
  List<RatingsModel>? ratings;
  List<DiscountsModel>? discounts;
  RatingsScoreModel? ratingScore;
  var supports;
  var pages;
  int tabTarget = 0;
  TextEditingController? contactMessageController;
  var box = GetStorage();
  int ratingAvarage = 0;
  late List<String> staticFooterPages = [];

  LoginModel? loginInfo;
  bool isLoading = false;
  late List<AddressModel> addresses = [];
  late List<OrdersModel> orders = [];
  late List<AddressModel> billing_addresses = [];
  TextEditingController? emailController;
  TextEditingController? passwordController;

  TextEditingController? emailControllerRegister;
  TextEditingController? passwordControllerRegister;
  TextEditingController? passwordRepeatController;
  TextEditingController? firstnameController;
  TextEditingController? surnameController;
  TextEditingController? phoneController;
  TextEditingController? supportTitlecontroller;
  TextEditingController? supportDesccontroller;

  TextEditingController? addressController;
  TextEditingController? apartmentController;
  TextEditingController? otherLabelController;
  bool otherAddressVisible = false;
  var addressLabel;
  var groupvalue;
  var checkboxTerms = false, checkboxNewsletter = false;

  var addressGroupvalue;

  AddressModel? selectedAddress;
  AreaModel? selectedAreas, selectedArea;
  List<AnnouncmentModel>? annouuncements;

  File? profilePhoto;
  var image;
  String? profilePhotoUrl;

  GoogleSignInAccount? _currentUser;
  String platform = 'ANDROID';
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      // 'https://www.googleapis.com/auth/contacts.readonly',
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile'
    ],
  );
  Future<void> addAddress(String address, String postalCode, String label, int type) async {
    try {
      isLoading = true;
      var result = await RemoteServices.addAddress(address, postalCode, label, type);

      if (result == "1") {
        getAddress(type);
        Get.snackbar('Erfolg', 'Die Adresse wurde erfolgreich hinzugefügt.');
      } else {
        Get.snackbar(
          'Fehler',
          'Beim Hinzufügen der Adresse ist ein Fehler aufgetreten',
          icon: Icon(
            Icons.error,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isLoading = false;
    }
  }

  Future addPImage(XFile imageFile) async {
    final box = GetStorage();
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("https://7zwerge.orderio.de/request.php");

    var request = http.MultipartRequest("POST", uri);
    request.fields['api'] = '1';
    request.fields['action'] = "30";
    var multipartFile = http.MultipartFile("profile_photo", stream, length, filename: path.basename(imageFile.path));

    request.files.add(multipartFile);

    var respond = await request.send();
    if (respond.statusCode == 200) {
      respond.stream.transform(utf8.decoder).listen((value) {
        print(value);
        if (value != '0') {
          profilePhotoUrl = value;
          box.write('profilePhotoUrl', profilePhotoUrl);
        } else {
          profilePhotoUrl = "https://ui-avatars.com/api/?size=128&name=" + loginInfo!.firstname + " " + loginInfo!.surname;
        }
      });
      print("Image Uploaded");
    } else {
      print("Upload Failed");
    }

    update();
  }

  Future<void> checkCoordinate(String coordinate, String shopName, String address, formattedAddress) async {
    try {
      isLoading = true;
      var result = await RemoteServices.checkCoordinate(coordinate);
      if (result != null && result != '[]') {
        CartUpdateModel cevap = cartUpdateModelFromJson(result);
        if (cevap.areas != null) {
          selectedArea = cevap.areas;
        }
        if (cevap.status == 2) {
          Get.dialog(
            AlertDialog(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              titlePadding: EdgeInsets.zero,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: HexColor.fromHex(box.read('primaryColor')),
                    height: 40,
                    padding: EdgeInsets.only(left: 20, right: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Rabattakionen
                        Text("Warnung",
                            style: const TextStyle(
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w900,
                                fontFamily: "Avenir",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0),
                            textAlign: TextAlign.left),

                        GestureDetector(
                          onTap: (() => {Get.back()}),
                          child: Container(
                              height: 30,
                              width: 30,
                              child: Icon(
                                Icons.close_rounded,
                                color: MyColors.watermelon,
                              ),
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(19)), color: MyColors.white)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                      child: Container(
                          child: Text(address + ' liegt nicht im Liefergebiet von ' + shopName,
                              style: const TextStyle(
                                  color: MyColors.darkText,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Avenir",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.0)))),
                ],
              ),
            ),
          );

          //  Get.snackbar('Uyarı', address + ' liegt nicht im Liefergebiet von ' + shopName);
        } else {
          ProductController productController = Get.find();
          productController.addressController!.text = formattedAddress;
          productController.addressText = formattedAddress;
          productController.update();
        }
        update();
      } else {}
    } finally {
      isLoading = false;
    }
  }

  Future<void> createNewSupport({other = false, String title = "", String desc = ""}) async {
    try {
      isLoading = true;
      var result = await RemoteServices.createNewSupport(title, desc);

      if (result != null && result != '[]') {
        getSupport(other: other);

        update();
      } else {
        //    Get.snackbar('Warnung', 'No found address');
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> getAddress(int type) async {
    try {
      isLoading = true;
      var result = await RemoteServices.getAddress(type.toString());
      if (result != null && result != '[]') {
        if (type == 0) {
          addresses = addressModelFromJson(result);
        } else {
          billing_addresses = addressModelFromJson(result);
        }
        update();
      } else {
        //    Get.snackbar('Warnung', 'No found address');
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> getAnnouuncements() async {
    try {
      isLoading = true;
      var result = await RemoteServices.getAnnouuncements();

      if (result != null && result != '[]') {
        annouuncements = announcmentModelFromJson(result);
      } else {
        annouuncements = null;
      }
      update();
      //update();
    } finally {
      isLoading = false;
    }
  }

  Future<void> getAreas() async {
    try {
      isLoading = true;
      var result = await RemoteServices.getAreas();

      if (result != null && result != '[]') {
        areas = areaModelFromJson(result);
        selectedArea = areas[0];
      } else {
        areas = null;
      }
      update();
      //update();
    } finally {
      isLoading = false;
    }
  }

  Future<void> getDiscounts() async {
    try {
      isLoading = true;
      var result = await RemoteServices.getDiscounts();
      print(result);
      if (result != null && result != '[]') {
        discounts = discountsModelFromJson(result);
      } else {}
      update();
      //update();
    } finally {
      isLoading = false;
    }
  }

  Future<void> getOrders() async {
    try {
      isLoading = true;
      var result = await RemoteServices.getOrders();

      if (result != null && result != '[]') {
        orders = ordersModelFromJson(result);

        update();
      } else {
        //    Get.snackbar('Warnung', 'No found address');
      }
    } finally {
      isLoading = false;
    }
  }

  getPages() async {
    try {
      var list = await RemoteServices.getStaticPages();

      if (list != null && list != '[]' && list != '') {
        pages = staticModelFromJson(list);
        update();
      } else {
        pages = null;
        //  Get.snackbar('Warnung', 'No found product in cart');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getRatings() async {
    try {
      isLoading = true;
      var result = await RemoteServices.getRatings();
      var result2 = await RemoteServices.getRatingScore();

      if (result != null && result != '[]') {
        ratings = ratingsModelFromJson(result);

        if (result2 != null && result2 != '[]') {
          ratingScore = ratingsScoreModelFromJson(result2);
          var doubleVal = double.parse(ratingScore!.ratingAverage.toString());
          var star = doubleVal.round();
          ratingAvarage = star;
        }
      } else {}
      update();
      //update();
    } finally {
      isLoading = false;
    }
  }

  Future<void> getServicesAndPrivacy() async {
    try {
      isLoading = true;
      var result = await RemoteServices.getServicePolicy();
      var result2 = await RemoteServices.getPrivacyPolicy();
      var result3 = await RemoteServices.getImpressum();

      if (result != null && result != '[]' && result2 != null && result2 != '[]' && result3 != null && result3 != '[]') {
        staticFooterPages = [result, result2, result3];
        print(staticFooterPages);
        update();
      } else {
        //    Get.snackbar('Warnung', 'No found address');
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> getShopContact() async {
    try {
      isLoading = true;
      var result = await RemoteServices.getShopContact();

      if (result != null && result != '[]') {
        shopContact = shopCotactModelFromJson(result);
      } else {}
      update();
      //update();
    } finally {
      isLoading = false;
    }
  }

  Future<void> getSupport({other = false}) async {
    try {
      isLoading = true;
      var result = await RemoteServices.getSupports();

      if (result != null && result != '[]') {
        supports = supportFromJson(result);
        if (other) {
          Get.to(CustomerSupport(data: supports[supports.length - 1]));
        }
      } else {
        supports = null;
      }
      update();
      //update();
    } finally {
      isLoading = false;
    }
  }

  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> login() async {
    try {
      isLogin = true;
      final box = GetStorage();
      var result = await RemoteServices.login(emailController!.text, passwordController!.text);
      ProductController productController = Get.find();
      if (result != null && result != '') {
        if (result != "0") {
          loginInfo = loginModelFromJson(result);
          box.write('userId', result);
          box.write('email', emailController!.text);
          box.write('password', passwordController!.text);
          box.write('firstname', loginInfo?.firstname);
          box.write('surname', loginInfo?.surname);
          box.write('phone', loginInfo?.phone);
          box.write('shop_id', loginInfo?.shopId);
          await getSupport();
          await getAddress(0);
          await getAddress(1);
          await getOrders();

          isLoading = true;
          Get.to(Home());
        } else {
          productController.customModal(title: "Sie haben einen falschen Benutzernamen oder ein falsches Passwort eingegeben", status: "error");
        }
      } else {
        productController.customModal(title: "Sie haben einen falschen Benutzernamen oder ein falsches Passwort eingegeben", status: "error");
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> loginPassive() async {
    try {
      isLoading = true;
      final box = GetStorage();
      var result = await RemoteServices.login(emailController!.text, passwordController!.text);

      if (result != null && result != '') {
        if (result != "0") {
          loginInfo = loginModelFromJson(result);
          box.write('userId', result);
          box.write('email', emailController!.text);
          box.write('password', passwordController!.text);
          box.write('firstname', loginInfo?.firstname);
          box.write('surname', loginInfo?.surname);
          box.write('phone', loginInfo?.phone);
          box.write('shop_id', loginInfo?.shopId);
          //  Get.to(Home());
        } else {
          /* Get.snackbar(
            'Warnung',
            'You entered an incorrect username or password',
            icon: Icon(
              Icons.error,
              color: Colors.white,
            ),
            backgroundColor: Colors.yellow.shade700,
            colorText: Colors.white,
          ); */
        }
      } else {
        /* Get.snackbar(
          'Warnung',
          'You entered an incorrect username or password',
          icon: Icon(
            Icons.error,
            color: Colors.white,
          ),
          backgroundColor: Colors.yellow.shade700,
          colorText: Colors.white,
        ); */
      }
    } finally {
      isLoading = false;
    }
  }

  logout() {
    final box = GetStorage();
    box.remove('userId');
    box.remove('email');
    box.remove('password');
    loginInfo = null;
    isLogin = false;
    RemoteServices.clearSession();
    Get.offAll(SignIn());
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    emailController?.dispose();
    passwordController?.dispose();

    emailControllerRegister?.dispose();
    passwordControllerRegister?.dispose();
    passwordRepeatController?.dispose();
    firstnameController?.dispose();
    surnameController?.dispose();
    phoneController?.dispose();
    supportTitlecontroller?.dispose();
    supportDesccontroller?.dispose();

    addressController?.dispose();
    apartmentController?.dispose();
    otherLabelController?.dispose();

    contactMessageController?.dispose();
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    emailControllerRegister = TextEditingController();
    passwordControllerRegister = TextEditingController();
    passwordRepeatController = TextEditingController();
    firstnameController = TextEditingController();
    surnameController = TextEditingController();
    phoneController = TextEditingController();
    supportTitlecontroller = TextEditingController();
    supportDesccontroller = TextEditingController();
    addressController = TextEditingController();
    apartmentController = TextEditingController();
    otherLabelController = TextEditingController();
    contactMessageController = TextEditingController();
    final box = GetStorage();
    var userId = await box.read('userId');
    var email = await box.read('email');
    var password = await box.read('password');
    profilePhotoUrl = box.read('profilePhotoUrl');
    var firstOpen = box.read('firstOpen');

    getAnnouuncements();
    getAreas();
    getShopContact();
    getRatings();
    getDiscounts();
    getServicesAndPrivacy();

    if (userId != null) {
      var result = await RemoteServices.login(email, password);

      if (result != "0") {
        loginInfo = loginModelFromJson(userId);
        if (loginInfo != null) {
          firstnameController!.text = loginInfo!.firstname;
          surnameController!.text = loginInfo!.surname;
          phoneController!.text = loginInfo!.phone;
          emailController!.text = loginInfo!.email;
          passwordController!.text = loginInfo!.pword;
        }
        await getSupport();
        await getAddress(0);
        await getAddress(1);
        await getOrders();
        isLogin = true;
      }

      if (firstOpen == null) {
        Timer(Duration(seconds: 3), () => Get.to(InfoSlider()));
      } else {
        Timer(
            Duration(seconds: 3),
            () => Get.to(
                  Home(),
                ));
      }
    } else {
      Timer(
          Duration(seconds: 3),
          () => Get.to(
                Home(),
              ));
    }

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      _currentUser = account;
      update();

      if (_currentUser != null) {
        // _handleGetContact(_currentUser!);
        /*  displayName = data.displayName,
        email = data.email,
        id = data.id,
        photoUrl = data.photoUrl, */
      }
    });
    _googleSignIn.signInSilently();
    if (Platform.isAndroid) {
      platform = 'ANDROID';
    } else if (Platform.isIOS) {
      platform = 'IOS';
    }
    getPages();
  }

  Future<void> register() async {
    try {
      isLoading = true;
      final box = GetStorage();
      var result = await RemoteServices.register(
          firstnameController!.text, surnameController!.text, phoneController!.text, emailControllerRegister!.text, passwordControllerRegister!.text);

      if (result == "1") {
        box.write('phone', phoneController!.text);
        box.write('email', emailControllerRegister!.text);
        box.write('password', passwordControllerRegister!.text);
        customModal(title: "Sie haben sich erfolgreich registriert.", status: "success");

        var result2 = await RemoteServices.login(emailControllerRegister!.text, passwordControllerRegister!.text);

        box.write('userId', result2);
        emailController!.text = emailControllerRegister!.text;
        passwordController!.text = passwordControllerRegister!.text;
        loginPassive();
        image != null ? addPImage(image) : null;
        if (box.read('coordinateActive') != "1") {
          Get.to(Address(
            returnPage: 'home',
            type: 0,
          ));
        } else {
          Get.off(Home());
        }
      } else {
        customModal(title: "Es gibt einen registrierten Benutzer mit dieser E-Mail.", status: "error");
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> removeAddress(String id) async {
    try {
      isLoading = true;
      var result = await RemoteServices.removeAddress(id);

      if (result != null && result != '[]') {
        update();
        getAddress(0);
        getAddress(1);
      } else {
        //    Get.snackbar('Warnung', 'No found address');
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> removeSupport(int id) async {
    try {
      isLoading = true;
      var result = await RemoteServices.removeSupport(id);

      if (result != null && result != '[]') {
        getSupport();
        update();
      } else {
        //    Get.snackbar('Warnung', 'No found address');
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> sendMessage(service_id, data) async {
    var message = contactMessageController?.text;
    if (message!.isNotEmpty) {
      var result = await RemoteServices.sendMessageSupport(service_id, message);
      if (result == "1") {
        data.responses!.add(Support(
          id: "1",
          subject: "1",
          customerId: "21",
          message: contactMessageController!.text,
          responseTo: "12",
          shopId: "qw",
          created: "qwe",
        ));
        contactMessageController?.text = '';

        update();
      }
    }
  }

  Future<void> updateProfile() async {
    try {
      isLoading = true;
      final box = GetStorage();
      var result = await RemoteServices.updateProfile(
          firstnameController!.text, surnameController!.text, phoneController!.text, emailController!.text, passwordController!.text);

      if (result == "1") {
        box.write('phone', phoneController!.text);
        box.write('email', emailController!.text);
        box.write('password', passwordController!.text);
        loginInfo!.firstname = firstnameController!.text;
        loginInfo!.surname = surnameController!.text;
        loginInfo!.phone = phoneController!.text;
        loginInfo!.email = emailController!.text;
        update();
        Get.snackbar(
          'Erfolg',
          'Die Änderungen wurden gespeichert',
        );
        // loginPassive();
      } else {
        customModal(title: "Es gibt einen registrierten Benutzer mit dieser E-Mail.", status: "error");
      }
    } finally {
      isLoading = false;
    }
  }
}
