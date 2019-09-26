const updateCustomerAddress = '''
mutation UpdateCustomerAccount(\$address:AddressType,\$phoneNumber:String){
    updateCustomerAccount(address:\$address,phoneNumber:\$phoneNumber){
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
