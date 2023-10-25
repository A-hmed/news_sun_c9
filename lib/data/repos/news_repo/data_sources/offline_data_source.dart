import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_sun_c9/data/model/sources_response.dart';

class OfflineDataSource {
  Future<SourcesResponse?> getSources(String categoryId) async {
    CollectionReference tabsCollection =
    FirebaseFirestore.instance.collection("tabs");
    // QuerySnapshot querySnapshot = await tabsCollection.get();
    // querySnapshot.d
    DocumentReference documentReference = tabsCollection.doc(categoryId);
    DocumentSnapshot docSnapshot =  await documentReference.get();
    if(docSnapshot.data() == null) return null;
    return SourcesResponse.fromJson(docSnapshot.data());
  }

  saveSources(SourcesResponse sourcesResponse, String categoryId) {
    CollectionReference tabsCollection =
        FirebaseFirestore.instance.collection("tabs");
    // .withConverter<SourcesResponse>(
    //     fromFirestore: (snapshot, _) =>
    //         SourcesResponse.fromJson(snapshot.data()),
    //     toFirestore: (response, _) => response.toJson());

    DocumentReference documentReference = tabsCollection.doc(categoryId);
    documentReference.set(sourcesResponse);
  }
}
