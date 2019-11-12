const String fcmIntegerateToken =
    """ mutation IntegrateFCMToken(\$fcmToken:String) {
        integrateFCMToken(fcmToken: \$fcmToken) {
          id 
          name
    fcmToken
        }
}
""";
