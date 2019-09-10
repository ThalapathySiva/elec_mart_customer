const String getCustomerOrders = """
query GetCustomerOrders{
  getCustomerOrders{
    orders{
      id
      orderNo
      address
      customer{
        phoneNumber
        name
        address
      }
      cartItems{
        inventory{
       name
       sellingPrice
       imageUrl
        }
      }
      status
      datePlaced
      updatedDate
      totalPrice
      paymentMode
      transactionSuccess
    }
    
  }
}""";
