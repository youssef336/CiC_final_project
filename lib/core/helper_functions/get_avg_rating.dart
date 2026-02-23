num getAvgRating(List<dynamic> reviews) {
  var sum = 0.0;
  for (var review in reviews) {
    sum += review.rating;
  }
  return sum / reviews.length;
}
