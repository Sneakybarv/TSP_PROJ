
import g4p_controls.*;

BruteForceSolver bruteForceSolver;
NearestNeighborSolver nearestNeighborSolver;
BranchAndBoundSolver branchAndBoundSolver;
String currentSolver = "BruteForce"; // Default solver
PVector[] cities; // Array of cities
float citiesNUM = 4;


// Timer variables
float bruteForceTime = 0;
float nearestNeighborTime = 0;
float branchAndBoundTime = 0;

void setup() {
  size(800, 800);
  generateCities(citiesNUM); // Example: 5 cities
  initializeSolvers();
  createGUI();  
  // Start Brute Force Solver in a separate thread
  thread("startBruteForceSolver");
}

//Label the starting city 
void labelStartingPoint(PVector city) {
fill(0, 102, 204);
textSize(16);
textAlign(CENTER, CENTER);
 text("Start", city.x, city.y - 15);
}

void draw() {
  background(255);

  // Display the selected solver's results
  if (currentSolver.equals("BruteForce")) {
    bruteForceSolver.drawCurrentRoute();
    bruteForceSolver.drawBestRoute();
    bruteForceSolver.displayResult();
    displaySolverName("Brute Force Method");
  } else if (currentSolver.equals("NearestNeighbor")) {
    nearestNeighborSolver.drawRoute();
    nearestNeighborSolver.displayResult();
    displaySolverName("Nearest Neighbor Method");
  } else if (currentSolver.equals("BranchAndBound")) {
    branchAndBoundSolver.drawBestRoute();
    branchAndBoundSolver.displayResult();
    displaySolverName("Branch and Bound Method");
  }

  // Display the solver timers
  displayTimers();
}

// Display the solver name at the top
void displaySolverName(String name) {
  fill(0);
  textSize(24);
  textAlign(CENTER, TOP);
  text(name, width / 2, 20);
}

// Display the runtimes of all solvers
void displayTimers() {
  fill(0);
  textSize(16);
  textAlign(LEFT, TOP);
  text("Brute Force Time: " + nf(bruteForceTime, 1, 3) + " seconds", 10, height - 60);
  text("Nearest Neighbor Time: " + nf(nearestNeighborTime, 1, 3) + " seconds", 10, height - 40);
  text("Branch and Bound Time: " + nf(branchAndBoundTime, 1, 3) + " seconds", 10, height - 20);
}

// Handle keypress to switch solvers
void keyPressed() {
  if (key == ' ') { // Space toggles between solvers
    toggleSolver();
  } else if (key == 'r' || key == 'R') { // 'R' key to reset
    resetSimulation();
  }
}

// Reset the simulation
void resetSimulation() {
  generateCities(citiesNUM); // Adjust the number of cities as needed
  initializeSolvers();
  thread("startBruteForceSolver"); // Restart Brute Force Solver in a new thread
}

// Toggle between solvers
void toggleSolver() {
  if (currentSolver.equals("BruteForce")) {
    currentSolver = "NearestNeighbor";
  } else if (currentSolver.equals("NearestNeighbor")) {
    currentSolver = "BranchAndBound";
  } else if (currentSolver.equals("BranchAndBound")) {
    currentSolver = "BruteForce";
  }
}

// Generate random cities
void generateCities(float numCities) {
  cities = new PVector[(int) numCities]; // Cast float to int
  for (int i = 0; i < cities.length; i++) {
    cities[i] = new PVector(random(50, width - 50), random(50, height - 50));
  }
}

// Initialize solvers
void initializeSolvers() {
  long startNN = System.currentTimeMillis();
  nearestNeighborSolver = new NearestNeighborSolver(cities);
  nearestNeighborSolver.solve();
  long endNN = System.currentTimeMillis();
  nearestNeighborTime = (endNN - startNN) / 1000.0;

  bruteForceSolver = new BruteForceSolver(cities, 100);

  long startBB = System.currentTimeMillis();
  branchAndBoundSolver = new BranchAndBoundSolver(cities);
  branchAndBoundSolver.solve();
  long endBB = System.currentTimeMillis();
  branchAndBoundTime = (endBB - startBB) / 1000.0;
}

// Start Brute Force Solver in a thread
void startBruteForceSolver() {
  long startBF = System.currentTimeMillis();
  bruteForceSolver.solve();
  long endBF = System.currentTimeMillis();
  bruteForceTime = (endBF - startBF) / 1000.0;
}
