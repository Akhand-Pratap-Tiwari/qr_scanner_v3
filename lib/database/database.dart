import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../secrets/secrets.dart';

class User {
  String name;
  String regId;
  String entryTime;
  String exitTime;
  String isCheckedIn;
  String isCheckedOut;

  static const Map<String, String> defMap = {
    'name': 'ResponseError',
    'regId': 'ResponseError',
    'entryTime': 'ResponseError',
    'exitTime': 'ResponseError',
    'isCheckedIn': 'ResponseError',
    'isCheckedOut': 'ResponseError',
  };

  User({
    required this.name,
    required this.regId,
    required this.entryTime,
    required this.exitTime,
    required this.isCheckedIn,
    required this.isCheckedOut,
  });

  Map<String, String> toMap() {
    return {
      'name': name,
      'regId': regId,
      'entryTime': entryTime,
      'exitTime': exitTime,
      'isCheckedIn': isCheckedIn,
      'isCheckedOut': isCheckedOut,
    };
  }

  User.fromMap(Map<String, dynamic>? map)
      : name = (map ?? defMap)['name'] ?? 'NullFieldError',
        regId = (map ?? defMap)['regId'] ?? 'NullFieldError',
        entryTime = (map ?? defMap)['entryTime'] ?? 'NullFieldError',
        exitTime = (map ?? defMap)['exitTime'] ?? 'NullFieldError',
        isCheckedIn = (map ?? defMap)['isCheckedIn'] ?? 'NullFieldError',
        isCheckedOut = (map ?? defMap)['isCheckedOut'] ?? 'NullFieldError';

  void displayData() => debugPrint(
      'debug: $name $regId $entryTime $exitTime $isCheckedIn $isCheckedOut');
}

class MongoDatabase {
  // static String dbStr = s_db;
  // static late Future<Db> db;
  static late DbCollection userCollection;

  static Future<Db> connect(
      {required String dbName, required collecName}) async {
    return Db.create('mongodb+srv://$secs/$dbName?retryWrites=true&w=majority');
  }

  static insert(User user) async =>
      await userCollection.insertAll([user.toMap()]);

  static Future<User> fetch({required String regId}) async {
    // await userCollection.findOne(
    //     where.eq("", regId).fields(
    //       [
    //         'name',
    //         'regId',
    //         'entryTime',
    //         'exitTime',
    //         'isCheckedIn',
    //         'isCheckedOut',
    //       ],
    //     ),
    //   ).then((value) => debugPrint("debug: " + value.toString()));
    return User.fromMap(
      await userCollection.findOne(
        where.eq("order_no", regId).fields(
          [
            'name',
            'regId',
            'entryTime',
            'exitTime',
            'isCheckedIn',
            'isCheckedOut',
          ],
        ),
      ),
    );
  }

  static update({required String regId, required bool isInEntryMode}) {
    String dateTime =
        DateTime.now().hour.toString() + DateTime.now().minute.toString();
    userCollection.updateOne(
      where.eq('order_no', regId),
      isInEntryMode
          ? modify
              .set('entryTime', dateTime)
              .set('isCheckedIn', 'true')
              .set('isCheckedOut', 'false')
          : modify
              .set('exitTime', dateTime)
              .set('isCheckedOut', 'true')
              .set('isCheckedIn', 'false'),
    );
  }
}
