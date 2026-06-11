class ParticleSystem {
  ArrayList<Particle3D> particles;
  int emitRate;

  ParticleSystem(int _emitRate) {
    emitRate = _emitRate;
    particles = new ArrayList<Particle3D>();
  }

  void update(PVector position) { // position needs x, y and z

    // emit new particles
    for (int i = 0; i < emitRate; i++) {
      // add new particles to the ArrayList
      particles.add(
        new Particle3D(position.x, position.y, position.z)
      );
    }

    // Achteruit loopen bij verwijderen
    for (int i = particles.size() - 1; i >= 0; i--) {
      Particle3D p = particles.get(i); // https://processing.org/reference/ArrayList.html
      p.update();

      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }

  void render() {
    // really intersting way to darken colours when they overlap:
    // https://processing.org/reference/blendMode_.html
    blendMode(ADD);

    for (Particle3D p : particles) {
      p.render();
    }

    blendMode(BLEND);
  }
}

