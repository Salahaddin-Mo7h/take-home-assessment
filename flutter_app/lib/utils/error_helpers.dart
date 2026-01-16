import '../core/errors/app_exceptions.dart';
import '../core/strings/app_strings.dart';

class ErrorHelpers {
  static String getErrorMessage(AppException error) {
    if (error is NetworkException) {
      return AppStrings.networkError;
    } else if (error is ApiException) {
      return AppStrings.apiError(error.message);
    } else if (error is DataParsingException) {
      return AppStrings.dataParsingError;
    }
    return error.message;
  }
}
