import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:zwerge/models/addressModel.dart';
import 'package:zwerge/models/areaModel.dart';
import 'package:zwerge/models/loginModel.dart';
import 'package:zwerge/models/productModel.dart';
import 'package:zwerge/utils/helper.dart';

import '../utils/Constants.dart';

class RemoteServices {
  static var client = http.Client();
  static Map<String, String> headers = {};

  static Future<String?> addAddress(String address, String postalCode, String label, int type) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "26";
    map['address'] = address;
    map['delivery_area_id'] = postalCode;
    map['label'] = label;
    map['is_billing'] = type.toString();
    var response = await client.post(url, body: map, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> addToCart(Product? item, Variant? variant, bool haveVariant, int quantitiy, String options) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    var productExtras = [];

    if (item!.extras != null && item.extras!.length > 0) {
      for (var productExtra in item.extras!) {
        if (productExtra.check) {
          productExtras.add(productExtra.extraId.toString());
        }
      }
    }
    if (haveVariant) {
      var eselection = "";
      for (var item in variant!.extras) {
        if (item.check) {
          productExtras.add(item.extraId);
          eselection += '"' + item.extraId + '", ';
        }
      }
      if (eselection.length > 2) {
        eselection = '[' + eselection.substring(0, eselection.length - 2) + ']';
      } else {
        eselection = "[]";
      }
      map['api'] = "1";
      map['action'] = "16";
      map['extras'] = productExtras.toString();
      map['eselection'] = options.toString();
      map['product_id'] = item.id.toString();
      map['variant_id'] = variant.id.toString();
      map['quantity'] = quantitiy.toString();
    } else {
      map['api'] = "1";
      map['action'] = "16";
      map['quantity'] = "1";
      map['extras'] = productExtras.toString();
      map['eselection'] = options.toString();
      map['variant_id'] = "0";
      map['product_id'] = item.id.toString();
    }
    var response = await client.post(url, body: map, headers: headers);
    updateCookie(response);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> addToWhishlist(String product_id) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "25";
    map['product_id'] = product_id;

    var response = await client.post(url, body: map, headers: headers);
    updateCookie(response);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> checkCoordinate(String coordinate) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "71";
    map['coordinate'] = coordinate;
    var response = await client.post(url, body: map, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> checkout(
      AddressModel? adres, LoginModel? user, AreaModel? area, String note, int payment, String selectedDeliveryTime) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');

    map['api'] = "1";
    map['action'] = "29";
    map['payment'] = payment.toString();
    map['note'] = note;
    map['name'] = user!.firstname.toString() + " " + user.surname.toString();
    map['email'] = user.email.toString();
    map['phone'] = user.phone.toString();
    map['company'] = "company";
    map['address'] = adres!.address.toString();
    map['postal'] = area!.postal.toString();
    map['city'] = area.city.toString();
    map['delivery_time'] = selectedDeliveryTime.toString() == "current" ? currentDate() : selectedDeliveryTime.toString();
    ;
    map['sessionid'] = "1";
    map['address_label'] = adres.label.toString();
    map['delivery_area_id'] = area.id.toString();
    map['delivery_amount'] = area.deliveryAmount.toString();

    var response = await client.post(url, body: map, headers: headers);
    updateCookie(response);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> checkoutNoLogin(String name, String email, String phone, String address, String company, String note, LoginModel? user,
      AreaModel? area, int payment, String selectedDeliveryTime) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    // current date
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');

    map['api'] = "1";
    map['action'] = "29";
    map['payment'] = payment.toString();
    map['note'] = note != null ? note : "";
    map['name'] = name != null ? name : "";
    map['email'] = email != null ? email : "";
    map['phone'] = phone != null ? phone : "";
    map['company'] = company != null ? company : "";
    map['address'] = address != null ? address : "";
    map['postal'] = area!.postal.toString();
    map['city'] = area.city.toString();
    map['delivery_time'] = selectedDeliveryTime.toString() == "current" ? currentDate() : selectedDeliveryTime.toString();
    map['sessionid'] = "1";
    map['address_label'] = "nicht eingeloggt";
    map['delivery_area_id'] = area.id.toString();
    map['delivery_amount'] = area.deliveryAmount.toString();
    var response = await client.post(url, body: map, headers: headers);
    updateCookie(response);
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> clearSession() async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "1111";
    var response = await client.post(url, body: map, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> createNewSupport(title, desc) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "11";
    map['subject'] = title.toString();
    map['message'] = desc.toString();

    var response = await client.post(url, body: map, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> discountCheck(String code) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "20";
    map['coupon_code'] = code;

    var response = await client.post(url, body: map, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> discountRemove() async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "21";

    var response = await client.post(url, body: map, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> dumpSession() async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "2222";
    var response = await client.post(url, body: map, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> editAddress(int id, String address, String postalCode, String label, int type) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "9";
    map['id'] = id.toString();
    map['label'] = label;
    map['area_id'] = postalCode.toString();
    map['address'] = address;
    map['is_billing'] = type;
    var response = await client.post(url, body: map, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> editProductNote(String id, String note) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "19";
    map['id'] = id;
    map['note'] = note;
    var response = await client.post(url, body: map, headers: headers);
    updateCookie(response);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getAddress(String type) async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=15&is_billing=' + type);
    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getAnnouuncements() async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=16');
    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getAreas() async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=17');
    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getCartList() async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=7');
    var response = await client.get(url, headers: headers);
    print(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getDeliveryTimes() async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=25&shop_id=' + shopID.toString());
    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getDiscounts() async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=5');
    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getFaq() async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=23');

    var response = await client.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getImpressum() async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=888');
    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getOptions() async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=66');
    final box = GetStorage();

    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      box.write('options', response.body);
      return response.body;
    } else {
      if (box.read("options") != null) {
        return box.read("options");
      } else {
        return null;
      }
    }
  }

  static Future<String?> getOrders() async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=12');
    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getPrivacyPolicy() async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=10');
    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getProductInfo(int productId) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "6";
    map['id'] = productId.toString();
    var response = await client.post(url, body: map, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getProducts(String shopId) async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=' + shopId);
    /* var map = new Map<String, dynamic>();
    map['system_no'] = systemNo;
    map['kullanici_kodu'] = kullaniciKodu;
    map['parola'] = parola; */
    var response = await client.get(
      url, headers: headers,
      // body: map,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getRatings() async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=4');
    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getRatingScore() async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=3');
    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getServicePolicy() async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=8');
    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getShopContact() async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=11');
    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getStaticPages() async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=24');
    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getSupports() async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=13');
    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getWhishlist() async {
    var url = Uri.parse('https://demo.orderio.de/request.php?get=18');
    var map = new Map<String, dynamic>();
    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> login(String email, String password) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "1";
    map['email'] = email;
    map['pword'] = password;
    var response = await client.post(url, body: map, headers: headers);
    updateCookie(response);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> register(String firstname, String surname, String phone, String email, String password) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "5";
    map['firstname'] = firstname;
    map['surname'] = surname;
    map['phone'] = phone;
    map['email'] = email;
    map['pword'] = password;
    var response = await client.post(url, body: map, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> removeAddress(String address_id) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "9";
    map['id'] = address_id.toString();
    var response = await client.post(url, body: map, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> removeFromCart(int id) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "17";
    map['id'] = id.toString();
    var response = await client.post(url, body: map, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> removeFromWhishlist(String product_id) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "27";
    map['product_id'] = product_id;
    var response = await client.post(url, body: map, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> removeSupport(int support_id) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "12";
    map['id'] = support_id.toString();
    var response = await client.post(url, body: map, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> sendMessageSupport(String response_id, String message) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "13";
    map['message'] = message;
    map['response_to'] = response_id;

    var response = await client.post(url, body: map, headers: headers);
    updateCookie(response);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> setDefaultAddress(int address_id) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "8";
    map['id'] = address_id.toString();
    var response = await client.post(url, body: map, headers: headers);
    updateCookie(response);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> setDeliveryAddress(int area) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "4";
    map['area'] = area.toString();
    var response = await client.post(url, body: map, headers: headers);
    updateCookie(response);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> setGelAl() async {
    //"{"status":1,"delivery_min":"1,00","delivery_amount":"0,00","total_amount":"0,00","amount":"0,00"}"

    var url = Uri.parse('https://demo.orderio.de/request.php?get=72');
    var map = new Map<String, dynamic>();
    map['action'] = "72";
    var response = await client.post(url, body: map, headers: headers);
    updateCookie(response);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
    return null;
  }

  static Future<String?> updateCart(int id, int quantity) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "18";
    map['cart_id'] = id.toString();
    map['quantity'] = quantity.toString();
    var response = await client.post(url, body: map, headers: headers);
    updateCookie(response);
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      return null;
    }
  }

  static updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] = (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  static Future<String?> updateProfile(String firstname, String surname, String phone, String email, String password) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "7";
    map['firstname'] = firstname;
    map['surname'] = surname;
    map['phone'] = phone;
    map['email'] = email;
    map['pword'] = password;
    var response = await client.post(url, body: map, headers: headers);
    updateCookie(response);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> updateSocialPhoto(String photoUrl) async {
    var url = Uri.parse('https://demo.orderio.de/request.php');
    var map = new Map<String, dynamic>();
    map['api'] = "1";
    map['action'] = "33";
    map['address'] = photoUrl;
    var response = await client.post(url, body: map, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
