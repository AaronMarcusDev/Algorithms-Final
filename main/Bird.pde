class Bird {
  PVector pos;        // Current position of the bird
  PVector noiseTime;  // Time offsets for Perlin Noise tracking

  // New rotation angles assigned uniquely per bird using Gaussian distribution
  float rotX, rotY, rotZ;

  color birdColor = color(200, 100, 250);
  
  Bird(float x, float y, float z) {
    pos = new PVector(x, y, z);
    
    // Choose unique random starting points so noise curves aren't identical
    noiseTime = new PVector(random(1000), random(2000), random(3000));

    // Processing's randomGaussian() yields a mean of 0 and a standard deviation of 1.
    // Multiplying this value adjusts the spread (standard deviation) in radians.

    rotX = randomGaussian() * radians(15);  // Pitch: Most tilt slightly up/down (15° dev)
    rotY = randomGaussian() * radians(180); // Yaw: Birds can spawn facing any random direction around the circle
    rotZ = randomGaussian() * radians(25);  // Roll: Most banking angles stay close to flat (25° dev)
  }

  void fly() {
    // 1. Calculate a step/velocity vector based on noise (-1 to 1 range)
    // map(noise, 0, 1, -maxSpeed, maxSpeed)
    float vx = map(noise(noiseTime.x), 0, 1, -4, 4);
    float vy = map(noise(noiseTime.y), 0, 1, -4, 4);
    float vz = map(noise(noiseTime.z), 0, 1, -2, 2);

    // 2. Add the noise velocity to the bird's active position
    pos.x += vx;
    pos.y += vy;
    pos.z += vz;

    // 3. Keep birds on screen (Optional: Constrain or Wrap around boundaries)
    pos.x = constrain(pos.x, 50, width - 50);
    pos.y = constrain(pos.y, 50, height - 50);
    pos.z = constrain(pos.z, -1000, -100);

    // 4. Advance your noise timeline
    noiseTime.x += random(0.001, 0.007);
    noiseTime.y += random(0.001, 0.007);
    noiseTime.z += random(0.001, 0.003);
  }


  void display() {
    pushMatrix();
    // Move the coordinate center to the bird's active position
    translate(pos.x, pos.y, pos.z);

    // --- APPLY GAUSSIAN ROTATIONS ---
    // Apply pitch, yaw, and roll so each bird has its own unique flight posture
    rotateY(rotY);
    // rotateX(rotX);
    // rotateZ(rotZ);

    // Calculate wing flapping angle using a sine wave
    float flapSpeed = millis() * 0.0075;
    float flapAngle = sin(flapSpeed) * radians(15); // Flaps 45 degrees up/down

    // --- 1. Body & Details ---
    fill(birdColor);
    noStroke();
    pushMatrix();
    sphere(20);
    popMatrix();

    // Eye 1
    pushMatrix();
    translate(10, 0, 15);
    fill(0);
    sphere(5);
    popMatrix();

    // Eye 2
    pushMatrix();
    translate(-10, 0, 15);
    sphere(5);
    popMatrix();

    fill(birdColor);

    // --- 2. Left Wing ---
    pushMatrix();
    rotateY(flapAngle);
    translate(-30, 0, 0);
    fill(100, 50, 150);
    box(40, 5, 20);
    popMatrix();

    // --- 3. Right Wing ---
    pushMatrix();
    rotateY(-flapAngle);
    translate(30, 0, 0);
    fill(100, 50, 150);
    box(40, 5, 20);
    popMatrix();

    popMatrix(); // Restores background isolation matrix
  }
}