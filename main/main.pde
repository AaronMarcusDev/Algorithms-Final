ArrayList<Bird> flock;
Terrain terrain;
BG bg;
Gun gun;
ColorSet colorset;
Menu menu;
Particle3D particle;
ParticleSystem ps;

void setup() {
  size(800, 600, P3D);

  // init classes
  terrain = new Terrain(3000, 1500, 20);
  bg = new BG();
  flock = new ArrayList<Bird>();
  colorset = new ColorSet();
  menu = new Menu();
  particle = new Particle3D(width / 2, height / 2, 100);
  ps = new ParticleSystem(2);
  //                      ^-- number of particles / emitrate

  // other variables
  menu.showMenu = false;

  // add 5 birds when starting
  for (int i = 0; i < 5; i++) {
    // Spawning birds across X, Y, and Z axes
    flock.add(new Bird(random(200, width-200), random(100, 300), random(-600, -200), colorset.getBirdColor()));
  }

  //?   gun = new Gun(width / 2 + 40, height / 2 +10, 450, 20, 4, 20);
  //   //                                   ^-- Z at 500 so it is in front of the camera, 0 seems to center it
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

  //   gun.display();

  // particle.update();
  // particle.render();
  PVector pp = new PVector(width/2, height/2, 100);

  particle.render();
  ps.update(pp);
  ps.render();

  menu.show();
}

void mouseClicked() {
  // Menu input handling
  if (menu.showMenu) {
    menu.handleClick();
    return;
  }

  // Bird spawning
  flock.add(new Bird(random(200, width-200), random(100, 300), random(-600, -200), colorset.getBirdColor()));
}

