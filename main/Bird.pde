class Bird {
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  float maxforce;    // Maximum steering control
  float maxspeed;    // Maximum forward speed
  color birdColor;

  Bird(float x, float y, float z) {
    acceleration = new PVector(0, 0, 0);
    // Give them a random 3D direction vector to start
    velocity = PVector.random3D().mult(random(1, 3));
    position = new PVector(x, y, z);
    
    maxspeed = 4.0;
    maxforce = 0.25; // Higher force means tighter turning adjustments
    birdColor = color(random(140, 180), random(40, 70), random(180, 220));
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

  // --- REYNOLDS FLOCKING RULES (ADAPTED TO 3D) ---
  void flock(ArrayList<Bird> birds) {
    PVector sep = separate(birds);   
    PVector ali = align(birds);      
    PVector coh = cohesion(birds);   
    
    // Weight parameters
    sep.mult(1.9);
    ali.mult(0.5);
    coh.mult(1.0);
    
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0); // Reset acceleration every cycle
  }

  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);  
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  
    return steer;
  }
  
  void render() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    
    // --- 3D ROTATION WITHOUT ATAN2 (Using Velocity direction) ---
    float rotY = atan2(velocity.x, velocity.z) + PI;
    float horizontalSpeed = sqrt(velocity.x * velocity.x + velocity.z * velocity.z);
    float rotX = atan2(-velocity.y, horizontalSpeed);
    float rotZ = velocity.x * 0.05; // Bank tilt
    
    rotateY(rotY); 
    rotateX(rotX); 
    rotateZ(rotZ);

    // Wing flapping animation mechanics
    float flapSpeed = millis() * 0.0075;
    float flapAngle = sin(flapSpeed) * radians(15); 

    // Render Bird Body Shapes
    fill(birdColor);
    noStroke();
    sphere(20); 

    // Eyes
    fill(0);
    pushMatrix(); translate(10, -5, 15); sphere(4); popMatrix();
    pushMatrix(); translate(-10, -5, 15); sphere(4); popMatrix();

    // Wings
    fill(birdColor - 30); 
    pushMatrix(); rotateY(flapAngle); translate(-30, 0, 0); box(40, 5, 20); popMatrix();
    pushMatrix(); rotateY(-flapAngle); translate(30, 0, 0); box(40, 5, 20); popMatrix();
    
    popMatrix();
  }

  void borders() {
    // Soft constraint boxes keeping them safely bound above the ground
    position.x = constrain(position.x, 50, width - 50);
    position.y = constrain(position.y, 50, 400); // 400 pixels caps them away from the floor mesh
    position.z = constrain(position.z, -1000, -100);
  }

  // --- SEPARATION (3D Native via PVector.dist) ---
  PVector separate(ArrayList<Bird> birds) {
    float desiredseparation = 65.0; // Distance buffer between birds
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    for (Bird other : birds) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < desiredseparation)) {
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
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // --- ALIGNMENT (3D Native) ---
  PVector align(ArrayList<Bird> birds) {
    float neighbordist = 70;
    PVector sum = new PVector(0, 0, 0);
    int count = 0;
    for (Bird other : birds) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } else {
      return new PVector(0, 0, 0);
    }
  }

  // --- COHESION (3D Native) ---
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