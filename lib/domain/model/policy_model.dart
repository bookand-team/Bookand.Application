abstract class PolicyModelBase {}

class PolicyModelInit implements PolicyModelBase {}

class PolicyModelLoading implements PolicyModelBase {}

class PolicyModel implements PolicyModelBase {
  final String title;
  final String content;

  PolicyModel(this.title, this.content);
}
