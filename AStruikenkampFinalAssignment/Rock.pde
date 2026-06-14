class Rock {
  PVector pos;
  PVector vel;
  PVector grav;
  float size;
  int throwSpeed;
  Sphere3D sphereHelper;

  Rock(PVector startPos, PVector targetPos, int _throwSpeed, float s) {
    throwSpeed = _throwSpeed;
    size = s;

    sphereHelper = new Sphere3D();

    pos = startPos.copy(); // So that the pointer does not point to the original PVector
    //                        as we need to keep the starting point the same

    // Calculate the direction vector from start to target
    PVector direction = PVector.sub(targetPos, startPos);

    // Apply the launching velocity (normalize direction and multiply by speed)
    direction.normalize(); // get it back to a <1, 1, 1> Vector (thanks Mathematics 3)
    vel = direction.mult(throwSpeed);

    // Add gravity pushing straight down along the Y axis
    grav = new PVector(0, Constants.ROCK_GRAVITY, 0);
    //                     ^-- only affects y ofcourse
  }

  void update() {
    vel.add(grav); // Since the order of math doesn't matter, might as well add it to velocity
    pos.add(vel);
  }

  void display() {
    fill(100, 102, 105); // gray
    sphereHelper.render(pos, size);
  }

  // Check if the rock has fallen far below the terrain floor
  boolean isOut() {
    return pos.y > 800 || pos.z < -1500;
    //                              ^ unintuitively, -1500 is in the back ;-;
    //                                so -1500 is way too far too see anyways
  }
}
