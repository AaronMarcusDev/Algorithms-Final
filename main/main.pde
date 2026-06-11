// Aaron Struikenkamp s3731944 (UTwente)
// CreaTe Subject: Algorithms

ArrayList<Bird> flock;
ArrayList<Rock> rocks = new ArrayList<Rock>();
Terrain terrain;
BG bg;
ColorSet colorset;
Menu menu;
ParticleSystem ps;


void setup() {
  size(800, 600, P3D);

  // init classes
  terrain = new Terrain(3000, 1500, 20);
  bg = new BG();
  flock = new ArrayList<Bird>();
  colorset = new ColorSet();
  menu = new Menu();
  ps = new ParticleSystem(2);
  //                      ^-- number of particles / emitrate

  // other variables
  menu.showMenu = false;

  // add 5 birds when starting
  for (int i = 0; i < 5; i++) {
    // Spawning birds across X, Y, and Z axes
    flock.add(new Bird(random(200, width-200), random(100, 300), random(-600, -200), colorset.getBirdColor()));
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
      // terrain = new Terrain(3000, 1500, 20);
      terrain.maxHeight = menu.selectedTerrainHeight;
      terrain.generate();
    } else if (key == 'r') {
      flock.clear();
    }
  }

  terrain.display();

  for (Bird bird : flock) {
    bird.run(flock);
  }

  // Update and render active rocks
  for (int i = rocks.size() - 1; i >= 0; i--) {
    Rock r = rocks.get(i);
    r.update();
    r.display();

    // Remove rocks that miss and fall out of bounds (to save memory)
    if (r.isOut()) {
      rocks.remove(i);
    }
  }

  PVector pp = new PVector(width/2, height/2, 100); // temporary particle position

  // ps.update(pp);
  // ps.render();
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
    // LINKS: Schiet een steen af richting de vogels
    // Bird spawning
    flock.add(new Bird(random(200, width-200), random(100, 300), random(-600, -200), colorset.getBirdColor()));
  } else if (mouseButton == LEFT) {
    // Rock throwing
    PVector startPoint = new PVector(width / 2 + 40, height / 2 + 50, 450);
    PVector targetPoint = new PVector(mouseX, mouseY, -500);
    rocks.add(new Rock(startPoint, targetPoint, 35));
  }
}

