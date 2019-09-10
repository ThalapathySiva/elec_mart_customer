const String createNewOrder = '''
mutation CreateNewOrder(\$paymentMode:String,\$cartItemIds:[String]){
  createNewOrder(cartItemIds:\$cartItemIds,paymentMode:\$paymentMode){
    error{
      path
      message
    }
    orders{
      id
      orderNo
      customer
      {
        phoneNumber
        name
        address
      }
      cartItems{
        id
      }
      status
      datePlaced
      updatedDate
      totalPrice
      paymentMode
    }
  }}''';
