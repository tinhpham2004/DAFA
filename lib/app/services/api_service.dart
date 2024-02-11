import 'package:cloud_firestore/cloud_firestore.dart';

class APIService {
  final CollectionReference apiCollection =
      FirebaseFirestore.instance.collection('api');

  Future<String> FetchApi() async {
    String api = '';
    await apiCollection.doc('W5YiV0EayrNz2d6qZ0Ib').get().then((value) {
      api = (value.data() as dynamic)['openAI'].toString();
    });
    return api;
  }
}
