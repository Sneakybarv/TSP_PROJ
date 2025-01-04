class BruteForceSolver {
  PVector[] cities, currentRoute, bestRoute;
  float minDistance;
  boolean isAnimating = true;
  int frameDelay;

  BruteForceSolver(PVector[] cities, int frameDelay) {
    this.cities = cities.clone();
    this.currentRoute = cities.clone();
    this.bestRoute = cities.clone();
    this.minDistance = Float.MAX_VALUE;
    this.frameDelay = frameDelay;
  }

void solve() {
  // Fix the first city as the starting point
  PVector firstCity = cities[0];

  // Perform permutations starting from the second city onward
  permute(cities, 1); // Start from index 1 to keep the first city fixed
  isAnimating = false;
}


  void permute(PVector[] array, int startIndex) {
  if (startIndex == array.length) {
    float distance = calculateDistance(array);
    if (distance < minDistance) {
      minDistance = distance;
      bestRoute = array.clone();
    }
    currentRoute = array.clone();

    // Introduce delay for animation
    delay(frameDelay);
    return;
  }

  for (int i = startIndex; i < array.length; i++) {
    swap(array, startIndex, i);
    permute(array, startIndex + 1);
    swap(array, startIndex, i);
  }
}

  float calculateDistance(PVector[] route) {
    float distance = 0;
    for (int i = 0; i < route.length - 1; i++) {
      distance += dist(route[i].x, route[i].y, route[i + 1].x, route[i + 1].y);
    }
return distance + dist(route[route.length - 1].x, route[route.length - 1].y, route[0].x, route[0].y);
  }

  void swap(PVector[] array, int i, int j) {
    PVector temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }

  void drawCurrentRoute() {
    stroke(0, 0, 255);
    strokeWeight(1);
    noFill();
    beginShape();
    for (PVector city : currentRoute) vertex(city.x, city.y);
    endShape(CLOSE);
    drawCities(currentRoute);
  }

  void drawBestRoute() {
    if (!isAnimating) {
      background(255);
      stroke(0, 255, 0);
      strokeWeight(2);
      noFill();
      beginShape();
      for (PVector city : bestRoute) vertex(city.x, city.y);
      endShape(CLOSE);
      drawCities(bestRoute);

    }
  }

  void drawCities(PVector[] route) {
    fill(255, 0, 0);
    for (PVector city : route) ellipse(city.x, city.y, 10, 10);
    labelStartingPoint(route[0]);
  }

  void displayResult() {
    if (!isAnimating) {
      fill(0);
      textSize(20);
      textAlign(CENTER, CENTER);
      text("Shortest Distance: " + nf(minDistance, 1, 2), width / 2, height - 50);
    }
  }
}
