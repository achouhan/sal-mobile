import 'package:sal_patient_client/models/practitioner.dart';
import 'package:sal_patient_client/network/APIProvider.dart';

class PractitionerRepository {
  final APIProvider apiProvider;

  PractitionerRepository(this.apiProvider);

  Future<List<Practitioner>> getPractitioners(
      int page, Map<String, dynamic> filters) async {
    final response = await apiProvider.get('prod/client/search', filters);
    return Practitioner.fromJson(response);
  }

  Future<void> getPractitionerDetails(Practitioner practitioner) async {
    switch (practitioner.type) {
      case PractitionerType.counsellor:
        {
          final response = await apiProvider.get(
              'prod/client/counsellor', {'counsellor_id': practitioner.id});
          practitioner.updateDetails(response);
          break;
        }
      case PractitionerType.listener:
        {
          final response = await apiProvider
              .get('prod/client/listener', {'listener_id': practitioner.id});
          practitioner.updateDetails(response);
          break;
        }
      default:
        {
          print('Do nothing');
        }
    }
    return;
  }
}
