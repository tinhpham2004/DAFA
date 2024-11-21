import 'package:cloud_firestore/cloud_firestore.dart';

class APIService {
  final CollectionReference apiCollection =
      FirebaseFirestore.instance.collection('api');

  Future<String> FetchOpenAIApiKey() async {
    String api = '';
    await apiCollection.doc('W5YiV0EayrNz2d6qZ0Ib').get().then((value) {
      api = (value.data() as dynamic)['openAI'].toString();
    });
    return api;
  }

  Future<String> FetchFPTAIApiKey() async {
    String api = '';
    await apiCollection.doc('W5YiV0EayrNz2d6qZ0Ib').get().then((value) {
      api = (value.data() as dynamic)['FPTAI'].toString();
    });
    return api;
  }

    Future<String> FetchEncryptKey() async {
    String api = '';
    await apiCollection.doc('W5YiV0EayrNz2d6qZ0Ib').get().then((value) {
      api = (value.data() as dynamic)['encrypt_key'].toString();
    });
    return api;
  }
}
