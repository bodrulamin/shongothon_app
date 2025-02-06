import 'branch.dart';
import 'organization.dart';




class AllowedBranch {
  final Organization organization;
  final List<Branch> branches;

  AllowedBranch({
    required this.organization,
    required this.branches,
  });

  factory AllowedBranch.fromJson(Map<String, dynamic> json) {
    return AllowedBranch(
      organization: Organization.fromJson(json['organization']),
      branches: (json['branches'] as List)
          .map((branch) => Branch.fromJson(branch))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'organization': organization.toJson(),
      'branches': branches.map((branch) => branch.toJson()).toList(),
    };
  }
}
