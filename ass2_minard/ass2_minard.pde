Table table;
PFont font_style;
PImage image;

// How every row in the data imported will be saved
class City //defines location of the city with its location
{
  public float longc = 0;
  public float latc = 0;  
  public String city = "";
}
class Temp //defines the location, temperature, days, months
{
  public float longt = 0;
  public int temp = 0;
  public int days = 0;
  public String mon = "";
  public int day = 0;
}
class Surv //defines the number of survivors, direction of travel and division of army
{
  public float longp = 0;
  public float latp = 0;
  public int surv = 0;
  public String dir = "";
  public int div = 0;
}

ArrayList<City> cities = new ArrayList<City>();
ArrayList<Temp> temps = new ArrayList<Temp>();
ArrayList<Surv> survs = new ArrayList<Surv>();

float normalize_x(float x) 
{
  return norm(x, 24, 36.5) * width/1.5 + width/6;
}

float normalize_y(float y) 
{
  return norm(y, 53.9, 55.8) * -height/2 + height/1.5;
}

void setup() 
{
  size(1900, 1000);
  table = loadTable("minard-data.csv", "header");
  font_style = createFont("Dyonisius.ttf", 18);
  image = loadImage("old.jpg");
  image.resize(width, height);
  textFont(font_style);
    
   //imports every form of data it needs from the csv file 
  for (TableRow row : table.rows()) 
  {    
     if (!Double.isNaN(row.getFloat(0))) 
    {
      City c = new City();
      c.longc = row.getFloat(0);
      c.latc = row.getFloat(1);
      c.city = row.getString(2);
      cities.add(c);
    }

    if (!Double.isNaN(row.getFloat(3))) 
    {
      Temp t = new Temp();
      t.longt = row.getFloat(3);
      t.temp = row.getInt(4);
      t.days = row.getInt(5);
      t.mon = row.getString(6);
      t.day = row.getInt(7);
      temps.add(t);
    }

    Surv s = new Surv();
    s.longp = row.getFloat(8);
    s.latp = row.getFloat(9);
    s.surv = row.getInt(10);
    s.dir = row.getString(11);
    s.div = row.getInt(12);
    survs.add(s);
  }
}

void draw() 
{
  background(image);
  //fill(255,190);
  rect(0, 0, width, height);
  
  //Render temp
  for (int i = 0; i<6; i++) 
  {
    fill(#FFFFFF); 
    strokeWeight(2);
    stroke(#FFFFFF);
    line(250, i * 6 * 5 + 650, width-180,i * 6 * 5 + 650);
    strokeWeight(2);
    stroke(#0A090A);
    textAlign(RIGHT);
    text(i*6, 250-10, i * 6 * 5 + 655);
  }
  
  text("TEMPERATURE (C)", 250-40, 2.5 * 6 * 5 + 655);
  text("LONGITUDE", width/2+100, 6 * 6 * 5 + 655);
  
  fill(#FFFFFF); 
  strokeWeight(2);
  stroke(#FFFFFF);
  line(250+10, 650-10, 250 + 10,5 * 6 * 5 + 650+10);

  for (int i = 1; i<temps.size(); i++) 
  {
    Temp t_1 = temps.get(i);
    Temp t = temps.get(i-1);

    float x1 = t.longt;    
    float y1 = -t.temp * 5 + 650;
    float x2 = t_1.longt;
    float y2 = -t_1.temp * 5 + 650;  

    fill(#FFFFFF); 
    strokeWeight(2);
    stroke(#FFFFFF);
    line(normalize_x(x1), y1, normalize_x(x2), y2);    
    // Draw Point
    fill(#ecf0f1); 
    strokeWeight(2);    
    stroke(#8e44ad);
    ellipse(normalize_x(t.longt), -t.temp * 5 + 650, 5, 5);

    // Draw Bubble
    fill(#ecf0f1, 220); 
    strokeWeight(1);
    stroke(#8e44ad);    
    String text = t.temp + "°C" ;    
    float textWidth = textWidth(text);
    rect(normalize_x(t.longt) + 5, -t.temp * 5 + 650, textWidth+7, 17, 0, 3, 3, 3);
    fill(#0A090A); 
    textAlign(LEFT, CENTER);
    text(text, normalize_x(t.longt) + 9, -t.temp * 5 + 650+6.5);
   }    
   Temp t = temps.get(temps.size()-1);
   // Draw Point
   fill(#ecf0f1); 
   strokeWeight(2);    
   stroke(#8e44ad);
   ellipse(normalize_x(t.longt), -t.temp * 5 + 650, 5, 5);

    // Draw Bubble
   fill(#ecf0f1, 220); 
   strokeWeight(1);
   stroke(#8e44ad);    
   String text = t.temp + "°C" ;    
   float textWidth = textWidth(text);
   rect(normalize_x(t.longt) + 5, -t.temp * 5 + 650, textWidth+7, 17, 0, 3, 3, 3);
   fill(#0A090A); 
   textAlign(LEFT, CENTER);
   text(text, normalize_x(t.longt) + 9, -t.temp * 5 + 650+6.5); 
    
    
   // Render the lines for the size of the survivors
   float x1, y1, x2, y2;
   for (int i = survs.size()-2; i>=1; i--) 
   {
     Surv s = survs.get(i);
     if (s.div != survs.get(i+1).div) continue;
     
     //Select the colour
     float strokeW = norm(s.surv, 4000, 340000) * 40;
     strokeWeight(max(1, strokeW));
     float alpha = max(200, norm(s.surv, 4000, 340000) * 255);
     if (s.div == 1) 
     {
       if (s.dir.equals("A")) stroke(#FAF02D, alpha);
       else stroke(#FA9108, alpha);
     } 
     else if (s.div == 2) 
     {
      if (s.dir.equals("A")) stroke(#0863FC, alpha);
      else stroke(#0AFC08, alpha);
     } 
     else 
     {
      if (s.dir.equals("A")) stroke(#FC08D0, alpha);
      else stroke(#FC0015, alpha);
     }

     x1 = s.longp;
     y1 = s.latp;  
     x2 = survs.get(i+1).longp; 
     y2 = survs.get(i+1).latp;
     line(normalize_x(x1), normalize_y(y1), normalize_x(x2), normalize_y(y2));
   }

   Surv s = survs.get(0);
   float strokeW = norm(s.surv, 4000, 340000) * 40;
   strokeWeight(max(1, strokeW));
   float alpha = max(200, norm(s.surv, 4000, 340000) * 255);
   if (s.div == 1) 
   {
     if (s.dir.equals("A")) stroke(#FAF02D, alpha);
     else stroke(#FA9108, alpha);
   } 
   else if (s.div == 2) 
   {
     if (s.dir.equals("A")) stroke(#0863FC, alpha);
     else stroke(#0AFC08, alpha);
   } 
   else 
   {
     if (s.dir.equals("A")) stroke(#FC08D0, alpha);
     else stroke(#FC0015, alpha);
   }
   
   x1 = s.longp;
   y1 = s.latp;  
   x2 = survs.get(1).longp; 
   y2 = survs.get(1).latp;  
   line(normalize_x(x1), normalize_y(y1), normalize_x(x2), normalize_y(y2));
    
  // Render the Texts for the city labels
  for (City c : cities) 
  {
    fill(#ecf0f1); 
    strokeWeight(1);
    stroke(#FFFFFF);
    ellipse(normalize_x(c.longc), normalize_y(c.latc), 5, 5);

    fill(#ecf0f1, 220); 
    strokeWeight(1);
    stroke(#FFFFFF);
    float text_width = textWidth(c.city);
    rect(normalize_x(c.longc) + 5, normalize_y(c.latc), text_width+7, 17, 0, 3, 3, 3);    

    fill(#0A090A); 
    textAlign(LEFT, CENTER);
    text(c.city, normalize_x(c.longc) + 9, normalize_y(c.latc)+6.5);
  }
  
  //draw the label box
  fill(#FA9108, 150);
  stroke(#FFFFFF);
  rect(width/2 + 590, height/2, 10, 10);
  textSize(15); 
  //fill(0, 102, 153);
  textAlign(LEFT, CENTER);
  text("DIVISION 1 RETREAT", width/2 + 590+20, height/2+3);
  fill(#0AFC08, 150);
  stroke(#FFFFFF);
  rect(width/2 + 590, height/2 + 20, 10, 10);
  textSize(15); 
  //fill(0, 190);
  textAlign(LEFT, CENTER);
  text("DIVISION 2 RETREAT", width/2 + 590+20, height/2 + 20+3);
  fill(#FC0015, 150);
  stroke(#FFFFFF);
  rect(width/2 + 590, height/2 + 40, 10, 10);
  textSize(15); 
  //fill(0, 190);
  textAlign(LEFT, CENTER);
  text("DIVISION 3 RETREAT", width/2 + 590+20, height/2 + 40+3);

  fill(#FAF02D, 150);
  stroke(#FFFFFF);
  rect(width/2 + 590, height/2 + 60, 10, 10);
  textSize(15); 
  //fill(0, 190);
  textAlign(LEFT, CENTER);
  text("DIVISION 1 ATTACK", width/2 + 590+20, height/2 + 60+3);
  fill(#0863FC, 150);
  stroke(#FFFFFF);
  rect(width/2 + 590, height/2 + 80, 10, 10);
  textSize(15); 
  //fill(0, 190);
  textAlign(LEFT, CENTER);
  text("DIVISION 2 ATTACK", width/2 + 590+20, height/2 + 80+3);
  fill(#FC08D0, 150);
  stroke(#FFFFFF);
  rect(width/2 + 590, height/2 + 100, 10, 10);
  textSize(15); 
  //fill(0, 190);
  textAlign(LEFT, CENTER);
  text("DIVISION 3 ATTACK", width/2 + 590+20, height/2 + 100+3);



  noFill();
  stroke(#FFFFFF);
  rect(width/2+580, height/2 -10, 180, 130);
  
  // Top Label
  textAlign(CENTER);
  textSize(30); 
  fill(#FFFFFF); 
  text("CHARLES JOSEPH MINARD’S MAP OF NAPOLEON’S RUSSIA CAMPAIGN", width/2, height/2 - 350);    
  fill(0,220);
  textSize(15); 
  saveFrame("Final.jpg");
}
