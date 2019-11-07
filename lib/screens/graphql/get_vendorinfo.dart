const String getVendorInfo = """query getVendorInfo{
  getVendorInfo{
  user{
    phoneNumber
    alternativePhone1
    alternativePhone2
    }
    error{
      path
      message
    }
  }
}
""";
