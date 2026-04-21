class GetFirstName {
  static String getFirstName(String fullName) {
    return fullName.trim().split(" ").first;
  }
}
