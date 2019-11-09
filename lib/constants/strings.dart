class OrderStatuses {
  static const String PLACED_BY_CUSTOMER = 'PLACED_BY_CUSTOMER';
  static const String RECEIVED_BY_STORE = 'RECEIVED_BY_STORE';
  static const String PICKED_UP = 'PICKED_UP';
  static const String DELIVERED_AND_PAID = 'DELIVERED_AND_PAID';
  static const String CANCELLED_BY_STORE = 'CANCELLED_BY_STORE';
  static const String CANCELLED_BY_CUSTOMER = 'CANCELLED_BY_CUSTOMER';
  static const String TRANSACTION_FAILED = 'TRANSACTION_FAILED';
}

const String STRING_PICKED_UP =
    'Your order has been sent for delivery and is on the way.';

const String STRING_PLACED_BY_CUSTOMER =
    'Your order is awaiting store confirmation.';

const String STRING_RECEIVED_BY_STORE =
    'Your order has been confirmed. It will be on its way soon.';

const String STRING_DELIVERED_AND_PAID =
    'Your order has been delivered to you.';

const String STRING_TRANSACTION_FAILED = 'Your transaction was failed';

const String STRING_CANCELLED_BY_STORE =
    'Your order was cancelled by the store.';

const String STRING_CANCELLED_BY_CUSTOMER = 'You cancelled this order.';

class StringResolver {
  static String getTextForOrderStatus({String status}) {
    switch (status) {
      case OrderStatuses.CANCELLED_BY_CUSTOMER:
        {
          return STRING_CANCELLED_BY_CUSTOMER;
        }
      case OrderStatuses.CANCELLED_BY_STORE:
        {
          return STRING_CANCELLED_BY_STORE;
        }
      case OrderStatuses.DELIVERED_AND_PAID:
        {
          return STRING_DELIVERED_AND_PAID;
        }
      case OrderStatuses.PICKED_UP:
        {
          return STRING_PICKED_UP;
        }
      case OrderStatuses.PLACED_BY_CUSTOMER:
        {
          return STRING_PLACED_BY_CUSTOMER;
        }
      case OrderStatuses.RECEIVED_BY_STORE:
        {
          return STRING_RECEIVED_BY_STORE;
        }
      case OrderStatuses.TRANSACTION_FAILED:
      {
        return STRING_TRANSACTION_FAILED;
      }
    }
    return 'INVALID_STATUS_PROVIDED';
  }
}
