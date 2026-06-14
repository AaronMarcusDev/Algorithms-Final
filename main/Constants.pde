// I don't know if there is a better way to keep variables constant and shared,
// but I made this static class to keep easy access to constants
// that influence the mechanics of the program / game
// https://processing.org/reference/static.html


class Constants {
  // in C and Java I know constants are uppercase, so I did that here too.
  static final int COLLISION_DISTANCE = 35;

  // Spawning and normal distribution variables
  // center + (randomGaussian * spread)
  static final int SAMPLE_BIRD_COUNT = 7;
  static final float SPAWN_X_SPREAD = 160;
  static final float SPAWN_Y_SPREAD = 100;
  static final float SPAWN_Z_CENTER = -400;
  static final float SPAWN_Z_SPREAD = 150;

  // Particle and -System
  static final int PARTICLE_EMIT_RATE = 2;
  static final int EXPLOSION_DURATION_MS = 3000;
  static final float PARTICLE_GRAVITY = 0.04;
  static final int PARTICLE_MAX_LIFE = 80;

  // Terrain
  static final int TERRAIN_WIDTH = 3000;
  static final int TERRAIN_HEIGHT = 1500;
  static final int TERRAIN_GRID_SIZE = 20;

  // Rock
  static final float ROCK_SIZE = 15.0;
  static final float ROCK_GRAVITY = 0.25;
  static final float ROCK_OUT_Y_MAX = 800;
  static final float ROCK_OUT_Z_MIN = -1500;

  // Bird (physical)
  static final float BIRD_BODY_SIZE = 20.0;
  static final float BIRD_EYE_SIZE = 4.0;
  static final float BIRD_FLAP_SPEED = 0.0075;
  static final float BIRD_MAX_FLAP_ANGLE = 15.0;

  // Flocking
  static final float SEPARATION_WEIGHT = 2.0;
  static final float LIGNMENT_WEIGHT = 0.5;
  static final float COHESION_WEIGHT = 1.0;
}

