import '../../../../core/core.dart';
import '../../../domain_layer/domain_layer.dart';

abstract class ISearchRepository {
  Future<DualResponse<Failure, SearchResponseEntity>> search({
    required String searchTerm,
  });
}
