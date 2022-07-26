import 'package:live_tracking/utils/extensions/string_extension.dart';

extension EnumExtension on Enum {
  String get toStringValue {
    return name.capitalize;
  }
}
