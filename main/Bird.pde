class Bird {
  PVector position;
  PVector velocity;
  PVector acceleration;
  color birdColor;
  Sphere3D sphereHelper;
  int birdSize;

  Bird(float x, float y, float z, color c, int s) {
    acceleration = new PVector(0, 0, 0);
    // Give them a random 3D direction vector to start
    velocity = PVector.random3D().mult(random(1, 3));
    position = new PVector(x, y, z);
    birdColor = c;
    birdSize = s;
    sphereHelper = new Sphere3D();
  }

  void run(ArrayList<Bird> birds) {
    flock(birds); // Step 1: Calculate forces
    update();     // Step 2: Apply physics
    borders();    // Step 3: Handle constraints
    render();     // Step 4: Draw geometry
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  // Shiffmans Flocking methods adapted to 3D
  // ^-- https://processing.org/examples/flocking.html
  void flock(ArrayList<Bird> birds) {
    PVector sep = separate(birds);
    PVector ali = align(birds);
    PVector coh = cohesion(birds);

    // Weight parameters
    sep.mult(Constants.SEPARATION_WEIGHT);
    ali.mult(Constants.ALIGNMENT_WEIGHT);
    coh.mult(Constants.COHESION_WEIGHT);

    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(Constants.BIRD_MAX_SPEED);
    position.add(velocity);
    acceleration.mult(0); // Reset acceleration every cycle
  }

  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);
    desired.normalize();
    desired.mult(Constants.BIRD_MAX_SPEED);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(Constants.BIRD_MAX_FORCE);
    return steer;
  }

  void render() {
    pushMatrix();
    translate(position.x, position.y, position.z);

    // 3D Rotation so they look where they are going (Thanks Maths 3)
    // Great explanation here: https://www.youtube.com/watch?v=qFSAcCwQS0E
    float rotY = atan2(velocity.x, velocity.z);
    float horizontalSpeed = sqrt(velocity.x * velocity.x + velocity.z * velocity.z);
    float rotX = atan2(-velocity.y, horizontalSpeed);
    float rotZ = velocity.x * 0.05; // Bank tilt

    rotateY(rotY);
    rotateX(rotX);
    rotateZ(rotZ);

    // Wing flapping animation mechanics
    float flapSpeed = millis() * Constants.BIRD_FLAP_SPEED;
    float flapAngle = sin(flapSpeed) * radians(Constants.BIRD_FLAP_ANGLE);

    // Render Bird Body Shapes
    fill(birdColor);
    sphere(birdSize); // in this case no Sphere3D as that requires a PVector

    // Eyes
    fill(0);
    sphereHelper.render(new PVector(10, -5, 15), birdSize/5);
    sphereHelper.render(new PVector(-10, -5, 15), birdSize/5);

    // Wings
    fill(red(birdColor)-51, green(birdColor)-51, blue(birdColor)-51);

    pushMatrix();
    rotateY(flapAngle);
    translate(-30, 0, 0);
    box(40, 5, 20);
    popMatrix();
    pushMatrix();
    rotateY(-flapAngle);
    translate(30, 0, 0);
    box(40, 5, 20);
    popMatrix();

    popMatrix();
  }

  void borders() {
    // Soft constraint boxes keeping them safely bound above the ground
    position.x = constrain(position.x, Constants.BIRD_CONSTRAINT_EDGE, width - 50);
    position.y = constrain(position.y, Constants.BIRD_CONSTRAINT_EDGE, Constants.BIRD_CONSTRAINT_TERRAIN); // 400 pixels caps them away from the floor mesh
    position.z = constrain(position.z, Constants.BIRD_CONSTRAINT_DEPTH, Constants.BIRD_CONSTRAINT_CAMERA);
  }

  PVector separate(ArrayList<Bird> birds) {
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    for (Bird other : birds) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < Constants.DESIRED_SEPARATION)) {
        //                        ^-- Distance buffer between birds
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);
        steer.add(diff);
        count++;
      }
    }

    if (count > 0) {
      steer.div((float)count);
    }

    if (steer.mag() > 0) {
      steer.normalize();
      steer.mult(Constants.BIRD_MAX_SPEED);
      steer.sub(velocity);
      steer.limit(Constants.BIRD_MAX_FORCE);
    }
    return steer;
  }

  // Alignment
  PVector align(ArrayList<Bird> birds) {
    PVector sum = new PVector(0, 0, 0);
    int count = 0;
    for (Bird other : birds) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < Constants.BIRD_NEIGHBOUR_DIST)) {
        sum.add(other.velocity);
        count++;
      }
    }

    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(Constants.BIRD_MAX_SPEED);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(Constants.BIRD_MAX_FORCE);
      return steer;
    } else {
      return new PVector(0, 0, 0);
    }
  }

  // Cohesion
  PVector cohesion(ArrayList<Bird> birds) {
    float neighbordist = 70;
    PVector sum = new PVector(0, 0, 0);
    int count = 0;
    for (Bird other : birds) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.position);
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);
    } else {
      return new PVector(0, 0, 0);
    }
  }
}
