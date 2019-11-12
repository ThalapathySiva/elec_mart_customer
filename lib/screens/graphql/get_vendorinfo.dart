const String getVendorInfo = """query getVendorInfo{
  getVendorInfo{
  user{
    phoneNumber
    alternativePhone1
    alternativePhone2
    email
    }
    error{
      path
      message
    }
  }
}
""";
