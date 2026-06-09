Bird myBird;
ArrayList<Bird> birds;
Terrain myTerrain;
BG bg;

color purple = color(45, 25, 80);
color orange  = color(235, 110, 85);

void setup() {
  size(800, 600, P3D);
  myTerrain = new Terrain(3000, 1500, 20);
  bg = new BG();
  birds = new ArrayList<Bird>();

  for (int i = 0; i < 15; i++) {
    birds.add(new Bird(random(100, width-100), random(100, 300), random(-1000, -200)));
  }
}

void draw() {
  background(0);
  hint(DISABLE_DEPTH_TEST); // Stops 3D depth interference --> https://processing.org/reference/hint_.html
  noStroke();               // Don't want shape borders

  bg.gradientRect(0, 0, width, height, purple, orange); // gradient background
  
  hint(ENABLE_DEPTH_TEST); 
  lights();

  myTerrain.display();

  for (Bird bird : birds) {
    bird.fly();
    bird.display();
  }
}
