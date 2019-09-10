const String customerRegister = """
  mutation CustomerRegister(\$phoneNumber:String,\$name:String,\$password:String,\$email:String)
{
  customerRegister(phoneNumber:\$phoneNumber,name:\$name,password:\$password,email:\$email){
    user{
      id 
      name
      phoneNumber
    }
    error{
      path
      message
    }
    jwtToken
  }
}
""";
