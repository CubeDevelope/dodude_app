import 'package:app/enums/endpoint.dart';
import 'package:cloud_functions/cloud_functions.dart';

class FirebaseRepository {
  loginWithEmail() {}

  loginWithNumber() {}

  Future httpsCallable(FirebaseFunctionEndpoints endpoint, {dynamic data}) async {
    var call = FirebaseFunctions.instance.httpsCallable(endpoint.toShortString);

    HttpsCallableResult result;
    result = await call.call();

    return result.data;
  }
}
