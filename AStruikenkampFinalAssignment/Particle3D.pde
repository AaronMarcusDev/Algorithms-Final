// The Particle3D Class is an adapted version of my self made particle2D class from assignment 4.
// I have noted everything I adapted with comments.
// The original class is added as comments below

class Particle3D {
  PVector pos;
  PVector vel;
  PVector acc;
  float life;
  float size;
  color c;
  Sphere3D particleSphere;

  Particle3D(float x, float y, float z) {
    // Added a z-axis to the position, velocity and acceleration
    pos = new PVector(x, y, z);
    // Explodes outwards in all directions including depth (Z)
    vel = new PVector(random(-1.25, 1.25), random(-2, -0.5), random(-1.25, 1.25));
    acc = new PVector(0, Constants.PARTICLE_GRAVITY, 0); // Constant downward gravity force on Y-axis

    life = 80;
    size = random(4, 8); // Slightly increased base size for better visibility in 3D depth
    particleSphere = new Sphere3D();

    c = getColor();
  }

  boolean isDead() {
    return life <= 0;
  }

  void update() {
    vel.add(acc);
    pos.add(vel);
    life--;
  }

  void render() {
    float lifeRatio = life / Constants.PARTICLE_MAX_LIFE; // in the original I called it aplha --> this should be more clear

    // Calculate a dynamic 3D size (older = smaller)
    float currentSize = size * lifeRatio;

    noStroke();

    // Solid fill color to prevent 3D rendering alpha clipping bugs
    fill(red(c), green(c), blue(c));
    particleSphere.render(pos, currentSize);
  }

  color getColor() { // only used within this class, not accessed from outside
    // grayish random colours
    return color(
      random(80, 110), 100, random(80, 110)
      );
  }
}

// The original (2D) particle class

// class Particle2D {
//   PVector pos;
//   PVector vel;
//   PVector acc;
//   float life;
//   float particleLifeLocal;
//   float size;
//   color c;

//   Particle2D(float x, float y) {
//     pos = new PVector(x, y);

//     // Randomly change velocity
//     vel = new PVector(random(-1.25, 1.25), random(-2, -0.5));
//     acc = new PVector(0, 0.04);

//     life = 80; // this one is being altered
//     particleLifeLocal = 80; // the local is used for alpha calculation at the end
//     size = random(3, 6);

//     c = getColor(); // returns a random purplish colour,
//     //                         Can be found at the bottom of the page.
//   }

//   boolean isDead() {
//     return life <= 0;
//   }

//   void update() {
//     vel.add(acc); // increase the velocity with a constant acceleration value
//     pos.add(vel); // then add a random velocity change movement to its position
//     life--; // make the particle shorten its lifespan
//   }

//   void render() {
//     float alpha = life / particleLifeLocal; // the 'older' the particle, the whiter it gets :)

//     noStroke();
//     fill(red(c), green(c), blue(c), 100 * alpha); // found out you can extract base colours from a mixed colour which is quite handy
//     //                                ^-- 255 was too intense of a white so I dialed it down a bit

//     circle(pos.x,pos.y, size * alpha * 2); // also decrease the size based on the alpha
//   }
// }
