const String createNewOrder = '''
mutation CreateNewOrder(\$paymentMode:String,\$cartItemIds:[String],\$additionalCharges:Float){
  createNewOrder(cartItemIds:\$cartItemIds,paymentMode:\$paymentMode,additionalCharges:\$additionalCharges){
    error{
      path
      message
    }
    orders{
      id
      orderNo
      additionalCharges
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
