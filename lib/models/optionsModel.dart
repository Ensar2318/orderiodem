// To parse this JSON data, do
//
//     final optionsModel = optionsModelFromJson(jsonString);

import 'dart:convert';

OptionsModel optionsModelFromJson(String str) => OptionsModel.fromJson(json.decode(str));

String optionsModelToJson(OptionsModel data) => json.encode(data.toJson());

class OptionsModel {
  String? id;

  String? shopId;
  String? header;
  String? logo;
  String? shortinfo;
  String? facebook;
  String? instagram;
  String? youtube;
  String? active;
  dynamic statusmessage;
  String? preorder;
  String? collection;
  String? paypal;
  String? klarna;
  String? cash;
  String? pos;
  String? onbill;
  String? primaryColor;
  String? secondaryColor;
  String? buttonColor;
  String? textColor;
  String? monday;
  String? mondayStart;
  String? mondayEnd;
  String? monday2Start;
  String? monday2End;
  String? tuesday;
  String? tuesdayStart;
  String? tuesdayEnd;
  String? tuesday2Start;
  String? tuesday2End;
  String? wednesday;
  String? wednesdayStart;
  String? wednesdayEnd;
  String? wednesday2Start;
  String? wednesday2End;
  String? thursday;
  String? thursdayStart;
  String? thursdayEnd;
  String? thursday2Start;
  String? thursday2End;
  String? friday;
  String? fridayStart;
  String? fridayEnd;
  String? friday2Start;
  String? friday2End;
  String? saturday;
  String? saturdayStart;
  String? saturdayEnd;
  String? saturday2Start;
  String? saturday2End;
  String? sunday;
  String? sundayStart;
  String? sundayEnd;
  String? sunday2Start;
  String? sunday2End;
  String? holiday;
  String? holidayStart;
  String? holidayEnd;
  String? holiday2Start;
  String? holiday2End;
  String? gmaps;
  String? analytics;
  String? metaTitle;
  String? metaDesc;
  String? metaKeywords;
  int? closed;
  String? coordinateActive;
  OptionsModel(
      {this.id,
      this.shopId,
      this.header,
      this.logo,
      this.shortinfo,
      this.facebook,
      this.instagram,
      this.youtube,
      this.active,
      this.statusmessage,
      this.preorder,
      this.collection,
      this.paypal,
      this.klarna,
      this.cash,
      this.pos,
      this.onbill,
      this.primaryColor,
      this.secondaryColor,
      this.buttonColor,
      this.textColor,
      this.monday,
      this.mondayStart,
      this.mondayEnd,
      this.monday2Start,
      this.monday2End,
      this.tuesday,
      this.tuesdayStart,
      this.tuesdayEnd,
      this.tuesday2Start,
      this.tuesday2End,
      this.wednesday,
      this.wednesdayStart,
      this.wednesdayEnd,
      this.wednesday2Start,
      this.wednesday2End,
      this.thursday,
      this.thursdayStart,
      this.thursdayEnd,
      this.thursday2Start,
      this.thursday2End,
      this.friday,
      this.fridayStart,
      this.fridayEnd,
      this.friday2Start,
      this.friday2End,
      this.saturday,
      this.saturdayStart,
      this.saturdayEnd,
      this.saturday2Start,
      this.saturday2End,
      this.sunday,
      this.sundayStart,
      this.sundayEnd,
      this.sunday2Start,
      this.sunday2End,
      this.holiday,
      this.holidayStart,
      this.holidayEnd,
      this.holiday2Start,
      this.holiday2End,
      this.gmaps,
      this.analytics,
      this.metaTitle,
      this.metaDesc,
      this.metaKeywords,
      this.closed,
      this.coordinateActive});

  factory OptionsModel.fromJson(Map<String, dynamic> json) => OptionsModel(
        id: json["id"],
        shopId: json["shop_id"],
        header: json["header"],
        logo: json["logo"],
        shortinfo: json["shortinfo"] ?? "",
        facebook: json["facebook"],
        instagram: json["instagram"],
        youtube: json["youtube"],
        active: json["active"],
        statusmessage: json["statusmessage"],
        preorder: json["preorder"],
        collection: json["collection"],
        paypal: json["paypal"],
        klarna: json["klarna"],
        cash: json["cash"],
        pos: json["pos"],
        onbill: json["onbill"],
        primaryColor: json["primary_color"],
        secondaryColor: json["secondary_color"],
        buttonColor: json["button_color"],
        textColor: json["text_color"],
        monday: json["monday"],
        mondayStart: json["monday_start"] != null ? json["monday_start"].substring(0, json["monday_start"].length - 3) : "null",
        mondayEnd: json["monday_end"] != null ? json["monday_end"].substring(0, json["monday_end"].length - 3) : "null",
        monday2Start: json["monday2_start"] != null ? json["monday2_start"].substring(0, json["monday2_start"].length - 3) : "null",
        monday2End: json["monday2_end"] != null ? json["monday2_end"].substring(0, json["monday2_end"].length - 3) : "null",
        tuesday: json["tuesday"],
        tuesdayStart: json["tuesday_start"] != null ? json["tuesday_start"].substring(0, json["tuesday_start"].length - 3) : "null",
        tuesdayEnd: json["tuesday_end"] != null ? json["tuesday_end"].substring(0, json["tuesday_end"].length - 3) : "null",
        tuesday2Start: json["tuesday2_start"] != null ? json["tuesday2_start"].substring(0, json["tuesday2_start"].length - 3) : "null",
        tuesday2End: json["tuesday2_end"] != null ? json["tuesday2_end"].substring(0, json["tuesday2_end"].length - 3) : "null",
        wednesday: json["wednesday"],
        wednesdayStart: json["wednesday_start"] != null ? json["wednesday_start"].substring(0, json["wednesday_start"].length - 3) : "null",
        wednesdayEnd: json["wednesday_end"] != null ? json["wednesday_end"].substring(0, json["wednesday_end"].length - 3) : "null",
        wednesday2Start: json["wednesday2_start"] != null ? json["wednesday2_start"].substring(0, json["wednesday2_start"].length - 3) : "null",
        wednesday2End: json["wednesday2_end"] != null ? json["wednesday2_end"].substring(0, json["wednesday2_end"].length - 3) : "null",
        thursday: json["thursday"],
        thursdayStart: json["thursday_start"] != null ? json["thursday_start"].substring(0, json["thursday_start"].length - 3) : "null",
        thursdayEnd: json["thursday_end"] != null ? json["thursday_end"].substring(0, json["thursday_end"].length - 3) : "null",
        thursday2Start: json["thursday2_start"] != null ? json["thursday2_start"].substring(0, json["thursday2_start"].length - 3) : "null",
        thursday2End: json["thursday2_end"] != null ? json["thursday2_end"].substring(0, json["thursday2_end"].length - 3) : "null",
        friday: json["friday"],
        fridayStart: json["friday_start"] != null ? json["friday_start"].substring(0, json["friday_start"].length - 3) : "null",
        fridayEnd: json["friday_end"] != null ? json["friday_end"].substring(0, json["friday_end"].length - 3) : "null",
        friday2Start: json["friday2_start"] != null ? json["friday2_start"].substring(0, json["friday2_start"].length - 3) : "null",
        friday2End: json["friday2_end"] != null ? json["friday2_end"].substring(0, json["friday2_end"].length - 3) : "null",
        saturday: json["saturday"],
        saturdayStart: json["saturday_start"] != null ? json["saturday_start"].substring(0, json["saturday_start"].length - 3) : "null",
        saturdayEnd: json["saturday_end"] != null ? json["saturday_end"].substring(0, json["saturday_end"].length - 3) : "null",
        saturday2Start: json["saturday2_start"] != null ? json["saturday2_start"].substring(0, json["saturday2_start"].length - 3) : "null",
        sunday: json["sunday"],
        sundayStart: json["sunday_start"] != null ? json["sunday_start"].substring(0, json["sunday_start"].length - 3) : "null",
        sundayEnd: json["sunday_end"] != null ? json["sunday_end"].substring(0, json["sunday_end"].length - 3) : "null",
        sunday2Start: json["sunday2_start"] != null ? json["sunday2_start"].substring(0, json["sunday2_start"].length - 3) : "null",
        sunday2End: json["sunday2_end"] != null ? json["sunday2_end"].substring(0, json["sunday2_end"].length - 3) : "null",
        holiday: json["holiday"],
        holidayStart: json["holiday_start"] != null ? json["holiday_start"].substring(0, json["holiday_start"].length - 3) : "null",
        holidayEnd: json["holiday_end"] != null ? json["holiday_end"].substring(0, json["holiday_end"].length - 3) : "null",
        holiday2Start: json["holiday2_start"] != null ? json["holiday2_start"].substring(0, json["holiday2_start"].length - 3) : "null",
        holiday2End: json["holiday2_end"] != null ? json["holiday2_end"].substring(0, json["holiday2_end"].length - 3) : "null",
        gmaps: json["gmaps"],
        analytics: json["analytics"],
        metaTitle: json["meta_title"],
        metaDesc: json["meta_desc"],
        metaKeywords: json["meta_keywords"],
        closed: json["closed"],
        coordinateActive: json["coordinateIsActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "header": header,
        "logo": logo,
        "shortinfo": shortinfo,
        "facebook": facebook,
        "instagram": instagram,
        "youtube": youtube,
        "active": active,
        "statusmessage": statusmessage,
        "preorder": preorder,
        "collection": collection,
        "paypal": paypal,
        "klarna": klarna,
        "cash": cash,
        "pos": pos,
        "onbill": onbill,
        "primary_color": primaryColor,
        "secondary_color": secondaryColor,
        "button_color": buttonColor,
        "text_color": textColor,
        "monday": monday,
        "monday_start": mondayStart,
        "monday_end": mondayEnd,
        "monday2_start": monday2Start,
        "monday2_end": monday2End,
        "tuesday": tuesday,
        "tuesday_start": tuesdayStart,
        "tuesday_end": tuesdayEnd,
        "tuesday2_start": tuesday2Start,
        "tuesday2_end": tuesday2End,
        "wednesday": wednesday,
        "wednesday_start": wednesdayStart,
        "wednesday_end": wednesdayEnd,
        "wednesday2_start": wednesday2Start,
        "wednesday2_end": wednesday2End,
        "thursday": thursday,
        "thursday_start": thursdayStart,
        "thursday_end": thursdayEnd,
        "thursday2_start": thursday2Start,
        "thursday2_end": thursday2End,
        "friday": friday,
        "friday_start": fridayStart,
        "friday_end": fridayEnd,
        "friday2_start": friday2Start,
        "friday2_end": friday2End,
        "saturday": saturday,
        "saturday_start": saturdayStart,
        "saturday_end": saturdayEnd,
        "saturday2_start": saturday2Start,
        "saturday2_end": saturday2End,
        "sunday": sunday,
        "sunday_start": sundayStart,
        "sunday_end": sundayEnd,
        "sunday2_start": sunday2Start,
        "sunday2_end": sunday2End,
        "holiday": holiday,
        "holiday_start": holidayStart,
        "holiday_end": holidayEnd,
        "holiday2_start": holiday2Start,
        "holiday2_end": holiday2End,
        "gmaps": gmaps,
        "analytics": analytics,
        "meta_title": metaTitle,
        "meta_desc": metaDesc,
        "meta_keywords": metaKeywords,
        "closed": closed,
      };
}
