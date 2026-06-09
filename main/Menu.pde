class Menu {
  void show() {
    // Blurry background
    fill(100, 100, 100, 150);
    //                   ^-- Opacity
    rect(0, 0, width, height);

    textAlign(CENTER, TOP);
    fill(255);
    textSize(36);
    text("MENU", width / 2, 80);

    // Divider
    stroke(255); // White line with transparency
    strokeWeight(2);
    line(width / 2 - 200, 135, width / 2 + 200, 135);

    textSize(18);
    fill(255);

    // Left-align the actual text but keep the block centered
    textAlign(LEFT, TOP);
    float startX = width / 2 - 130;
    float startY = 170;
    float spacing = 40; // Vertical gap between lines

    text("> 'g' to regenerate terrain", startX, startY);
    text("> 'r' to remove all current birds", startX, startY + spacing);
    text("> mouse click for spawning new bird", startX, startY + (spacing * 2));
    text("> 'm' for opening/closing menu", startX, startY + (spacing * 3));
  }
}
