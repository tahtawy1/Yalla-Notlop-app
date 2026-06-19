import 'package:flutter/material.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';

extension ContextExtension on BuildContext {
  S get l10n => S.of(this);
}
