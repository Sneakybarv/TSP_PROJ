class BranchAndBoundSolver {
  PVector[] cities;
  int numCities;
  boolean[] visited;
  float minCost;
  int[] bestRoute;

  BranchAndBoundSolver(PVector[] cities) {
    this.cities = cities;
    this.numCities = cities.length;
    this.visited = new boolean[numCities];
    this.minCost = Float.MAX_VALUE;
    this.bestRoute = new int[numCities + 1]; // Store the best route
  }

  // Solve using Branch and Bound
  void solve() {
    int[] currentRoute = new int[numCities + 1];
    currentRoute[0] = 0; // Start from the first city
    visited[0] = true;
    branchAndBound(0, 1, 0, currentRoute);
  }

  // Recursive Branch and Bound method
  void branchAndBound(int currentCity, int level, float cost, int[] currentRoute) {
    if (level == numCities) {
      // Complete the route by returning to the start
      cost += distance(cities[currentCity], cities[0]);
      if (cost < minCost) {
        minCost = cost;
        System.arraycopy(currentRoute, 0, bestRoute, 0, numCities);
        bestRoute[numCities] = 0; // Complete the loop
      }
      return;
    }

    for (int nextCity = 0; nextCity < numCities; nextCity++) {
      if (!visited[nextCity]) {
        float newCost = cost + distance(cities[currentCity], cities[nextCity]);
        if (newCost < minCost) { // Prune unpromising paths
          visited[nextCity] = true;
          currentRoute[level] = nextCity;
          branchAndBound(nextCity, level + 1, newCost, currentRoute);
          visited[nextCity] = false;
        }
      }
    }
  }

  // Calculate distance between two cities
  float distance(PVector a, PVector b) {
    return dist(a.x, a.y, b.x, b.y);
  }

  // Draw the best route
  void drawBestRoute() {
    stroke(0, 102, 204);
    strokeWeight(2);
    noFill();
    for (int i = 0; i < numCities; i++) {
      int cityA = bestRoute[i];
      int cityB = bestRoute[i + 1];
      line(cities[cityA].x, cities[cityA].y, cities[cityB].x, cities[cityB].y);
    }
    drawCities(); // Call drawCities to visualize cities
  }

  // New Method: Draw Cities
  void drawCities() {
    fill(0, 0, 255); // Blue for cities
    for (PVector city : cities) {
      ellipse(city.x, city.y, 10, 10); // Draw each city as a small circle
    }
    labelStartingPoint(cities[0]); // Label the starting point
  }

  // Helper Method: Label the starting city
  void labelStartingPoint(PVector start) {
    fill(0); // Black text
    textAlign(CENTER);
    text("Start", start.x, start.y - 10); // Display "Start" slightly above the starting city
  }

  // Display the result
  void displayResult() {
    fill(0);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("Branch and Bound Distance: " + nf(minCost, 1, 2), width / 2, height - 50);
  }
}
