const String getReviews = """query getReviews{
  getReviews{
   averageRating,
    reviews{
      text,
      customer{
        name
      }
    },
    error{
      path
      message
    }
  }
}""";
