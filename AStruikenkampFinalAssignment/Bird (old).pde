// class Bird {
//   PVector pos;
//   PVector noiseTime;  // Time offsets for Perlin Noise
//   float rotX, rotY, rotZ;// Rotation angles

//   // Unique personality offsets so they aren't completely identical
//   float personalYawOffset; // Yaw = horizontal rotation
//   float personalPitchOffset; // pitch = vertical rotation

//   color birdColor = color(200, 100, 250);

//   Bird(float x, float y, float z) {
//     pos = new PVector(x, y, z);
//     noiseTime = new PVector(random(1000), random(2000), random(3000));

//     // Small unique posture imperfections assigned once at birth
//     personalYawOffset = randomGaussian() * radians(5);
//     personalPitchOffset = randomGaussian() * radians(5);
//   }

//   void fly() {
//     // 1. Map the perlin noise to the speed vector
//     float vx = map(noise(noiseTime.x), 0, 1, -4, 4);
//     //                ^ curr value, min, max, new min, new max

//     float vy = map(noise(noiseTime.y), 0, 1, -4, 4);
//     float vz = map(noise(noiseTime.z), 0, 1, -2, 2);

//     pos.x += vx;
//     pos.y += vy;
//     pos.z += vz;

//     pos.y = constrain(pos.y, 50, 400); // So they do not go below the terrain

//     // 2. DE MAKKELIJKE ROTATIE: Gebruik ruis om de hoeken direct te veranderen
//     // We mappen de ruis naar een kleine verandering (bijv. tussen -0.05 en 0.05 radialen)
//     rotY += map(noise(noiseTime.x + 500), 0, 1, -0.03, 0.03);
//     rotX += map(noise(noiseTime.y + 500), 0, 1, -0.02, 0.02);
//     rotZ = vx * 0.05; // Simpele bank-hoek op basis van de zijwaartse snelheid

//     // 3. Randen controleren
//     pos.x = constrain(pos.x, 50, width - 50);
//     pos.z = constrain(pos.z, -1000, -100);

//     // 4. Tijdlijn vooruitspoelen
//     noiseTime.x += random(0.001, 0.007);
//     noiseTime.y += random(0.001, 0.007);
//     noiseTime.z += random(0.001, 0.003);
//   }


//   void display() {
//     pushMatrix();
//     translate(pos.x, pos.y, pos.z);

//     // --- APPLY DYNAMIC ROTATIONS ---
//     // The order matters! Yaw (Y) -> Pitch (X) -> Roll (Z)
//     rotateY(rotY);
//     rotateX(rotX);
//     rotateZ(rotZ);

//     // Calculate wing flapping angle using a sine wave
//     float flapSpeed = millis() * 0.0075;
//     float flapAngle = sin(flapSpeed) * radians(15);

//     // --- 1. Body & Details ---
//     fill(birdColor);
//     noStroke();
//     pushMatrix();
//     sphere(20);
//     popMatrix();

//     // Eye 1
//     pushMatrix();
//     translate(10, 0, 15);
//     fill(0);
//     sphere(5);
//     popMatrix();

//     // Eye 2
//     pushMatrix();
//     translate(-10, 0, 15);
//     sphere(5);
//     popMatrix();

//     fill(birdColor);

//     // --- 2. Left Wing ---
//     pushMatrix();
//     rotateY(flapAngle);
//     translate(-30, 0, 0);
//     fill(100, 50, 150);
//     box(40, 5, 20);
//     popMatrix();

//     // --- 3. Right Wing ---
//     pushMatrix();
//     rotateY(-flapAngle);
//     translate(30, 0, 0);
//     fill(100, 50, 150);
//     box(40, 5, 20);
//     popMatrix();

//     popMatrix();
//   }
// }

