Bird myBird;
ArrayList<Bird> birds;

void setup() {
  size(800, 600, P3D);
  birds = new ArrayList<Bird>();

  for (int i = 0; i < 15; i++) {
    birds.add(new Bird(random(20, width), random(20, height), random(-1000, -100)));
  }
}

void draw() {
  background(135, 206, 235); // Sky blue background
  lights();
  
  // Update the bird's position using Perlin noise and render it
  for (Bird bird : birds) {
    bird.fly();
    bird.display();
  }
}