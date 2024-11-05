import ddf.minim.*; // Tambahkan pustaka Minim untuk efek suara

PFont font1;
PFont font2;
PFont fontExternal;

String text = "Playing with Text";
ArrayList<Roach> coks;
PImage img;
Minim minim;
AudioPlayer hitSound;
int lastSpawnTime = 0;

void setup() {
  size(800, 800);
font1 = loadFont ("InkFree-48.vlw");
font2 = loadFont ("Cambria-BoldItalic-48.vlw");
fontExternal = createFont("Rustic Barn.ttf",40);
  coks = new ArrayList<Roach>();
  img = loadImage("semut.png");
  
  minim = new Minim(this);
  hitSound = minim.loadFile("tit.wav"); // Pastikan file suara "hit.mp3" ada di folder data

}

void draw() {
  background(#677FFF);
  

textFont(fontExternal);
textAlign(CENTER);
text("Mahceka Yankee",300, 150);
fill(#030303);

textFont(font2);
fill(#030303);
textAlign(CENTER);
text("22.11.4912",300,200);
  
  // Tambahkan kecoa otomatis setiap 5 detik
  if (millis() - lastSpawnTime > 5000) {
    addRandomRoach();
    lastSpawnTime = millis();
  }
  
  // Menampilkan semua kecoa
for (int i = coks.size() - 1; i >= 0; i--) {
    Roach c = coks.get(i);
    c.live();
  }

  fill(51);
  textSize(16);
  text("nums: " + coks.size(), 100, 750); 
}

// Fungsi untuk menambahkan kecoa di posisi acak
void addRandomRoach() {
  float randomX = random(width);
  float randomY = random(height);
  coks.add(new Roach(img, randomX, randomY));
}


void mouseClicked() {
  boolean hit = false;
  
  // Periksa apakah klik mengenai salah satu kecoa
  for (int i = coks.size() - 1; i >= 0; i--) {
    Roach c = coks.get(i);
    if (dist(mouseX, mouseY, c.pos.x, c.pos.y) < img.width / 2) {
      coks.remove(i); // Hapus kecoa dari ArrayList
      hit = true;
      break;
    }
  }
  
  // Mainkan efek suara
  if (hit) {
    hitSound.rewind();
    hitSound.play();
  }
}
