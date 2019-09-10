const updateCustomerAddress = '''
mutation UpdateCustomerAccount(\$address:AddressType){
    updateCustomerAccount(address:\$address){
   error{
     path
     message
   }
 }
}''';
