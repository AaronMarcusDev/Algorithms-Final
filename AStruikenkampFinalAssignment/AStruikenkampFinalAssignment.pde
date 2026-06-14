/*
 * Author: Aaron Struikenkamp s3731944
 * Course: Algorithms CreaTe 2025/2026
 * No collaboration
 * Sources used (also in README.md):
 * - Flocking: own implementation based on Shiffman's 2D implementation
 * - Particle system: adapted to 3D from my own Assignment 4
 * - Terrain Perlin noise: inspired by Nature of Code, but is my own code
 * - No AI used for programming logic, only for comparing against rubric and catching mistakes
 
 * Other sources used in code (like methods and equations)
 * - https://processing.org/reference/hint_.html
 * - https://processing.org/examples/flocking.html
 * - https://www.youtube.com/watch?v=qFSAcCwQS0E (atan & atan2)
 * - https://processing.org/reference/hint_.html (processing disable depth for text)
 * - https://processing.org/reference/ArrayList.html (ArrayList)
 * - https://processing.org/reference/blendMode_.html (blending colours for particles)
 * - https://processing.org/tutorials/2darray (2D Array for terrain grid)
 * - https://forum.processing.org/one/topic/create-a-rectangular-gradient-two-colours.html (background insp.)
*/

// Class definitions
ArrayList<Bird> flock;
ArrayList<Rock> rocks = new ArrayList<Rock>();
Terrain terrain;
BG bg;
ColorSet colorset;
Menu menu;
ParticleSystem ps;

// Necessary global variables
int timerStart;
PVector explosionPos;


void setup() {
  size(800, 600, P3D);

  // init classes
  terrain = new Terrain(
    Constants.TERRAIN_WIDTH,
    Constants.TERRAIN_HEIGHT,
    Constants.TERRAIN_GRID_SIZE
  );

  bg = new BG();
  flock = new ArrayList<Bird>();
  colorset = new ColorSet();
  menu = new Menu();
  ps = new ParticleSystem();

  // other variables
  menu.showMenu = false;
  timerStart = 0;
  explosionPos = new PVector(0, 0, 0);

  // add 7 birds when starting
  spawnSampleBirds(Constants.SAMPLE_BIRD_COUNT);
}

void spawnSampleBirds(int number) {
  for (int i = 0; i < number; i++) {
    // I use normal distribution to make them nice and centered,
    // but still not too predictable for the player
    flock.add(
      new Bird(
      (width / 2)  + (randomGaussian() * Constants.SPAWN_X_SPREAD), // can deviate +/-160px
      (height / 2) + (randomGaussian() * Constants.SPAWN_Y_SPREAD), // can deviate +/-100px
      Constants.SPAWN_Z_CENTER + (randomGaussian() * Constants.SPAWN_Z_SPREAD), // can deviate +/-150px from ~center of Z
      colorset.getBirdColor(),
      Constants.BIRD_SIZE // bird size
      )
    );
  }
}

void draw() {
  background(0);
  hint(DISABLE_DEPTH_TEST); // Stops 3D depth interference --> https://processing.org/reference/hint_.html
  noStroke();               // Don't want shape borders

  bg.gradientRect(0, 0, width, height, colorset.purple, colorset.orange); // gradient background

  hint(ENABLE_DEPTH_TEST);
  lights();

  if (keyPressed) {
    if (key == 'm') {
      menu.showMenu = !menu.showMenu;
      delay(80); // so that it has a bit of time;
      // otherwise it will close too quickly again since it still registers a key press;
    } else if (key == 'g') {
      terrain.maxHeight = menu.selectedTerrainHeight;
      terrain.generate();
    } else if (key == 'r') {
      flock.clear();
      spawnSampleBirds(Constants.SAMPLE_BIRD_COUNT);
      delay(100);
    }
  }

  terrain.display();

  for (Bird bird : flock) {
    bird.run(flock);
  }

  // Update and render active rocks + handle bird collision detection
  for (int i = rocks.size() - 1; i >= 0; i--) {
    Rock r = rocks.get(i);
    r.update();
    r.display();

    // Check rock against all birds to get 'hitbox' --> Just a distance vector in my case
    for (int j = flock.size() - 1; j >= 0; j--) {
      Bird b = flock.get(j);
      float distance = PVector.dist(r.pos, b.position);

      // if the distance is smaller than the 'hitbox', it means they touched
      if (distance < Constants.COLLISION_DISTANCE) {
        timerStart = millis();
        ps.clear();
        explosionPos = b.position.copy();
        flock.remove(j);
        rocks.remove(i);
        break;
      }
    }
  }

  if (millis() < timerStart + Constants.PARTICLES_DURATION) {
    ps.update(explosionPos); // Continuously runs gravity and movement physics at the anchor spot
    //                          Had a lot of issues before doing this
    ps.render();
  }

  menu.showHint();
  menu.show();
}

void mouseClicked() {
  // Menu input handling
  if (menu.showMenu) {
    menu.handleClick();
    return; // ignore other input functions while in menu
  }

  if (mouseButton == RIGHT) {
    // Bird spawning
    flock.add(new Bird(random(200, width-200), random(100, 300), random(-600, -200), colorset.getBirdColor(), Constants.BIRD_SIZE));
  } else if (mouseButton == LEFT) {
    // Rock throwing
    PVector startPoint = new PVector(width / 2 + 40, height / 2 + 50, 450);
    PVector targetPoint = new PVector(mouseX, mouseY, -500);
    rocks.add(new Rock(startPoint, targetPoint, 35, Constants.ROCK_SIZE));
  }
}

