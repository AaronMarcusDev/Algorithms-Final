ArrayList<Bird> flock;
Terrain terrain;
BG bg;

color purple = color(45, 25, 80);
color orange  = color(235, 110, 85);

void setup() {
  size(800, 600, P3D);
  terrain = new Terrain(3000, 1500, 20);
  bg = new BG();
  flock = new ArrayList<Bird>();

  for (int i = 0; i < 25; i++) {
    // Spawning birds across X, Y, and Z axes
    flock.add(new Bird(random(200, width-200), random(100, 300), random(-600, -200)));
  }
}

void draw() {
  background(0);
  hint(DISABLE_DEPTH_TEST); // Stops 3D depth interference --> https://processing.org/reference/hint_.html
  noStroke();               // Don't want shape borders

  bg.gradientRect(0, 0, width, height, purple, orange); // gradient background
  
  hint(ENABLE_DEPTH_TEST); 
  lights();

  terrain.display();

  for (Bird bird : flock) {
    bird.run(flock);
  }
}


