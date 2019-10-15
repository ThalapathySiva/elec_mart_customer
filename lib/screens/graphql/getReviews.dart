const String getReviews = """query getReviews(\$inventoryId:String){
  getReviews(inventoryId:\$inventoryId){
   averageRating,
   canReview,
    reviews{
      id,
      rating,
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
