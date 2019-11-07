const String posters = """query getPosters{
  getPosters{
    id,
    inventories{
       id,
      name,
      originalPrice,
      sellingPrice,
      description,
      imageUrl,
      category,
      inStock,
      deleted,
      date,
    },
    posterImage,
    vendor{
      shopPhotoUrl,
    storeName,
    address
    }
  
  }
}
""";
