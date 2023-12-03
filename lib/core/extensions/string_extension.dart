extension StringExtension on String {
  bool isEmail() {
    const regex = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    return RegExp(regex).hasMatch(this);
  }
}
