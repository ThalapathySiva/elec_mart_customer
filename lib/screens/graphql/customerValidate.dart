const String customerValidate = """
mutation ValidateCustomerArguments(\$phoneNumber:String, \$email:String){
  validateCustomerArguments(phoneNumber:\$phoneNumber, email:\$email){
    phoneNumber
    email
  }
}""";
