import 'package:sipardy_app/core/error/i_error.dart';

/// A class holding possible launch errors
class LaunchError extends IError {

  /// An error for when an URL could not be opened
  const LaunchError.urlNotOpened()
    : super('URL konnte nicht geöffnet werden.');
}