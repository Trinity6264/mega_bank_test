import "dart:convert";

import "package:bank/bank_observer.dart";
import "package:bank/data/model/data_model.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/services.dart" show rootBundle;
import "package:multiple_result/multiple_result.dart";
import "package:welltested_annotation/welltested_annotation.dart";

@Welltested()
class DataRepository {
  const DataRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<DataModel> _userCollection() {
    return _firestore.collection("customerStaticData").withConverter(
      fromFirestore: (snapshot, options) {
        final data = snapshot.data();

        return DataModel.fromJson(data ?? {});
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  Stream<DocumentSnapshot<DataModel>> loadUserData({required String id}) {
    return _userCollection().doc(id).snapshots();
  }

  Future<Result<DataModel, void>> loadJsonData() async {
    try {
      final jsonFile = await rootBundle.loadString(
        "assets/json/customer_data.json",
      );
      final jsonData = json.decode(jsonFile) as Map<String, dynamic>;

      final data = DataModel.fromJson(jsonData);
      logger.i(data);
      return Result.success(data);
    } catch (e) {
      logger.e(e);
      return const Result.error(null);
    }
  }
}
