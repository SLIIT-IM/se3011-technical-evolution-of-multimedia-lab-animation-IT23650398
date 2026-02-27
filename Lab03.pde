int state = 0; 
int startTime;
int duration = 30;

int score = 0;

float px = 350, py = 175;
float pr = 20;
float step = 6;

float hx, hy;
float ease = 0.08;

float ox, oy;
float r = 18;
float xs = 4;
float ys = 3;

float oxGold, oyGold;
float rGold = 20;
boolean goldActive = false;

boolean trails = false;
PFont gameFont;

void setup() {
  size(700, 350);
  gameFont = createFont("Poppins", 32);
  textFont(gameFont);

  hx = px;
  hy = py;

  resetOrb1();
}

void draw() {

  if (!trails) {
    background(245);
  } else {
    noStroke();
    fill(245, 40);
    rect(0, 0, width, height);
  }

  if (state == 0) {
    textAlign(CENTER, CENTER);
    background(#7874FF);

    fill(#000000);
    textSize(42);
    text("CATCH THE ORBS", width/2, height/2 - 50);

    textSize(20);
    fill(#000000);
    text("Press ENTER to Start", width/2, height/2);
  }

  if (state == 1) {

    int elapsed = (millis() - startTime) / 1000;
    int left = duration - elapsed;

    if (left <= 0) {
      state = 2;
    }

    if (keyPressed) {
      if (keyCode == RIGHT || keyCode == 'd' || keyCode == 'D') px += step;
      if (keyCode == LEFT || keyCode == 'a' || keyCode == 'A')  px -= step;
      if (keyCode == DOWN || keyCode == 's' || keyCode == 'S')  py += step;
      if (keyCode == UP || keyCode == 'w' || keyCode == 'W')    py -= step;
    }

    px = constrain(px, pr, width - pr);
    py = constrain(py, pr, height - pr);

    ox += xs;
    oy += ys;

    if (ox > width - r || ox < r) xs *= -1;
    if (oy > height - r || oy < r) ys *= -1;

    float d = dist(px, py, ox, oy);
    if (d < pr + r) {
      score++;
      xs *= 1.1;
      ys *= 1.1;
      resetOrb1();
    }
    
     if (score > 0 && score % 5 == 0 && !goldActive) {
      goldActive = true;
      resetGoldOrb();
    }

    if (goldActive && dist(px, py, oxGold, oyGold) < pr + rGold) {
      score += 3;     
      goldActive = false;
    }

    hx = hx + (px - hx) * ease;
    hy = hy + (py - hy) * ease;

    noStroke();
    fill(#E54F4F);
    ellipse(ox, oy, r*2, r*2);

    fill(#504FE5);
    ellipse(px, py, pr*2, pr*2);

    fill(#504FE5);
    ellipse(hx, hy, 14, 14);
    
    if (goldActive) {
      fill(#FFD700);
      ellipse(oxGold, oyGold, rGold*2, rGold*2);
    }
    
    fill(20);
    textAlign(LEFT, TOP);
    textSize(18);
    text("Score: " + score, 20, 20);
    text("Time: " + left, 20, 45);
    text("Press T for Trails", 20, 70);
  }

  if (state == 2) {
    textAlign(CENTER, CENTER);
    background(#7874FF);

    fill(#000000);
    textSize(40);
    text("TIME OVER!", width/2, height/2 - 40);

    fill(#000000);
    textSize(24);
    text("Final Score: " + score, width/2, height/2);

    textSize(18);
    text("Press R to Restart", width/2, height/2 + 40);
  }
}

void keyPressed() {

  if (state == 0 && keyCode == ENTER) {
    state = 1;
    startTime = millis();
    score = 0;
  }

  if (state == 2 && (key == 'r' || key == 'R')) {
    state = 0;
    px = width/2;
    py = height/2;
    xs = 4;
    ys = 3;
    score = 0;
    resetOrb1();
  }

  if (key == 't' || key == 'T') {
    trails = !trails;
  }
}

void resetOrb1() {
  ox = random(50, width - 50);
  oy = random(50, height - 50);
}

void resetGoldOrb() {
  oxGold = random(50, width - 50);
  oyGold = random(50, height - 50);
}
