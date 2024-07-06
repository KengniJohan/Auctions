enum LabelRole {
  admin,
  member;

  String toName() => toString().split('.').last.toUpperCase();

  static fromName(String name) =>
      LabelRole.values.firstWhere((role) => role.toName() == name,
          orElse: () => LabelRole.member);
}
