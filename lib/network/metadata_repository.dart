import 'package:sal_patient_client/models/Metadata.dart';
import 'package:sal_patient_client/network/APIProvider.dart';

class MetadataRepository {
  final APIProvider apiProvider;

  MetadataRepository(this.apiProvider);

  Future<Metadata> getMetadata() async {
    final response = await apiProvider.get('prod/meta', null);
    return Metadata.fromJson(response);
  }
}
