const updateCustomerAddress = '''
mutation UpdateCustomerAccount(\$address:AddressType,\$phoneNumber:String,\$name:String,\$password:String,\$otpToken:String){
    updateCustomerAccount(address:\$address,phoneNumber:\$phoneNumber,name:\$name,password:\$password,otpToken:\$otpToken){
      user{
      phoneNumber
      id
      email
      name
      }
   error{
     path
     message
   }
 }
}
''';
