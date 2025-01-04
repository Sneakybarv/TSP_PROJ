class NearestNeighborSolver {
  PVector[] cities, route;
  float totalDistance = 0;
  boolean solved = false;

  NearestNeighborSolver(PVector[] cities) {
    this.cities = cities;
    this.route = new PVector[cities.length];
  }

  void solve() {
    boolean[] visited = new boolean[cities.length];
    route[0] = cities[0];
    visited[0] = true;

    for (int i = 1; i < cities.length; i++) {
      int nearestCity = -1;
      float minDist = Float.MAX_VALUE;
      for (int j = 0; j < cities.length; j++) {
        if (!visited[j]) {
          float d = dist(route[i - 1].x, route[i - 1].y, cities[j].x, cities[j].y);
          if (d < minDist) {
            minDist = d;
            nearestCity = j;
          }
        }
      }
      route[i] = cities[nearestCity];
      visited[nearestCity] = true;
      totalDistance += minDist;
    }
  totalDistance += dist(route[route.length - 1].x, route[route.length - 1].y, route[0].x, route[0].y);
    solved = true;
  }

  void drawRoute() {
    stroke(255, 140, 0);
    strokeWeight(2);
    noFill();
    beginShape();
    for (PVector city : route) vertex(city.x, city.y);
    endShape(CLOSE);
    drawCities(route);
  }

  void drawCities(PVector[] route) {
    fill(0, 0, 255);
    for (PVector city : route) ellipse(city.x, city.y, 10, 10);
    labelStartingPoint(route[0]);
  }

  void displayResult() {
    if (solved) {
      fill(0);
      textSize(20);
      textAlign(CENTER, CENTER);
      text("Nearest Neighbor Distance: " + nf(totalDistance, 1, 2),  width / 2, height - 50);
    }
  }
}

//class NearestNeighborSolver {
//  PVector[] cities;
//  PVector[] currentRoute, bestRoute;
//  float totalDistance = 0;
//  boolean isAnimating = true;
//  int frameDelay;

//  NearestNeighborSolver(PVector[] cities, int frameDelay) {
//    this.cities = cities.clone();
//    this.currentRoute = new PVector[cities.length];
//    this.bestRoute = cities.clone();
//    this.frameDelay = frameDelay;
//  }

//  void solve() {
//    boolean[] visited = new boolean[cities.length];
//    currentRoute[0] = cities[0];
//    visited[0] = true;
//    totalDistance = 0;

//    for (int i = 1; i < cities.length; i++) {
//      PVector nearest = null;
//      int nearestIndex = -1;
//      float minDist = Float.MAX_VALUE;

//      for (int j = 0; j < cities.length; j++) {
//        if (!visited[j]) {
//          float dist = dist(currentRoute[i - 1].x, currentRoute[i - 1].y, cities[j].x, cities[j].y);
//          if (dist < minDist) {
//            minDist = dist;
//            nearest = cities[j];
//            nearestIndex = j;
//          }
//        }
//      }

//      visited[nearestIndex] = true;
//      currentRoute[i] = nearest;
//      totalDistance += minDist;

//      // Introduce animation delay
//      delay(frameDelay);
//    }

//    totalDistance += dist(currentRoute[cities.length - 1].x, currentRoute[cities.length - 1].y, cities[0].x, cities[0].y);
//    bestRoute = currentRoute.clone();
//    isAnimating = false;
//  }

//  void drawCurrentRoute() {
//    stroke(0, 0, 255);
//    strokeWeight(1);
//    noFill();
//    beginShape();
//    for (PVector city : currentRoute) vertex(city.x, city.y);
//    endShape(CLOSE);
//    drawCities(currentRoute);
//  }

//  void drawBestRoute() {
//    if (!isAnimating) {
//      background(255);
//      stroke(0, 255, 0);
//      strokeWeight(2);
//      noFill();
//      beginShape();
//      for (PVector city : bestRoute) vertex(city.x, city.y);
//      endShape(CLOSE);
//      drawCities(bestRoute);
//    }
//  }

//  void drawCities(PVector[] route) {
//    fill(255, 0, 0);
//    for (PVector city : route) ellipse(city.x, city.y, 10, 10);
//    labelStartingPoint(route[0]);
//  }

//  void displayResult() {
//    if (!isAnimating) {
//      fill(0);
//      textSize(20);
//      textAlign(CENTER, CENTER);
//      text("Shortest Distance: " + nf(totalDistance, 1, 2), width / 2, height - 50);
//    }
//  }
//}
