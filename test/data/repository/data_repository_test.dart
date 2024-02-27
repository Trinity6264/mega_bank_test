import "package:bank/data/model/data_model.dart";
import "package:bank/data/repository/data_repository.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/annotations.dart";

@GenerateNiceMocks([MockSpec<DataRepository>()])
void main() {
  late DataRepository mockdataRepository;
  setUpAll(
    TestWidgetsFlutterBinding.ensureInitialized,
  );

  setUp(
    () {
      mockdataRepository = DataRepository(
        firestore: FirebaseFirestore.instance,
      );
    },
  );

  test(
    "Testing loadJsonData() in the data repository class to see if the return type will be be the instance of DataModel",
    () async {
      // when(() => mockdataRepository.loadJsonData()).thenAnswer(
      //   (realInvocation) async{
      //     return  DataModel();
      //   },
      // );

      final resp = await mockdataRepository.loadJsonData();

      expect(resp.tryGetSuccess(), isA<DataModel>());
    },
  );

  test(
    "Testing loadJsonData() in the data repository class to see if it throws an error",
    () async {
      final resp = await mockdataRepository.loadJsonData();
      expect(resp.tryGetError, isA<void>());
    },
  );
}
