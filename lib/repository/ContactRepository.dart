import 'package:cognizant_assessment/network/ApiClient.dart';
import 'package:cognizant_assessment/network/BaseDataSource.dart';
import '../env/BuildEnvironment.dart';
import '../model/Contact.dart';
import '../network/Result.dart';

class ContactRepository extends BaseDataSource {
  final ApiClient apiClient = ApiClient();

  //ContactRepository({required this.apiClient})

  Future<Result> getContactList() async {
    return executeApiRequest(
        apiClient.dio,
        BuildEnvironment.environment.contactsUrl,
        HttpMethod.GET,
        null,
        contactFromJson);
  }
}
