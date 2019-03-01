Table table; 
PImage image;
PFont font_style;
ArrayList<Row> first = new ArrayList<Row>();
ArrayList<Row> second = new ArrayList<Row>();

// How every row in the data imported will be saved
class Row 
{
  public String mon = "";
  public int avg_size = 0;  
  public float d_zymotic_diseases = 0;
  public float d_wounds = 0;
  public float d_other = 0;
  public float a_zymotic_diseases = 0;
  public float a_wounds = 0;
  public float a_other = 0;
}

void setup() 
{
  size(1900, 1000);
  table = loadTable("nightingale-data-1.csv", "header");
  
  int i = 0;
  for (TableRow row : table.rows()) 
  {
    Row r = new Row();
    r.mon = row.getString(0);
    r.avg_size = row.getInt(1);
    r.d_zymotic_diseases = row.getFloat(2);
    r.d_wounds = row.getFloat(3);
    r.d_other = row.getFloat(4);
    r.a_zymotic_diseases = row.getFloat(5);
    r.a_wounds = row.getFloat(6);
    r.a_other = row.getFloat(7);
    if (i >= 13) 
     second.add(r);
    else 
    {
      first.add(r);
      i++;
    }
  }
  first.remove(0);
  image = loadImage("old.jpg");
  image.resize(width, height);
  font_style = createFont("Dyonisius.ttf", 20);
  textFont(font_style);
}

void draw() 
{
  background(image);
  fill(255,190);
  rect(0, 0, width, height);
 
  // Draw Pies
  float center_x = width/2 - width/6;
  float center_y = height/2 + 60;
  // Top Label
  textAlign(CENTER);
  textSize(26); 
  fill(0, 190);
  text("APRIL 1854 to MARCH 1855", center_x, height/2 - 210);    
  textSize(20); 

  for (int i =0; i<first.size(); i++) 
  {  
    Row r = first.get(i);
    // Calculate Pie Properties
    float s1 = r.a_zymotic_diseases/1.5;
    float s3 = r.a_wounds*1.2/1.5;
    float s2 = r.a_other*1.2/1.5;
    float ang1 = i*(360/first.size()) - 90;
    float ang2 = (360/first.size());   

    // Draw Text Labels
    float highest = max(s1, max(s2, s3));
    float distance = max(80, highest/2 + 10);
    float text_x = center_x + distance * cos(radians(ang1+ang2/2));
    float text_y = center_y + distance * sin(radians(ang1+ang2/2));    
    fill(0, 190);    
    textAlign(CENTER);
    pushMatrix();
    translate(text_x, text_y);
    rotate(radians(ang1+ang2/2+90));
    translate(-text_x, -text_y);
    String t = r.mon;
    String m = t.substring(0, t.indexOf(" "));
    text(m, text_x, text_y);
    popMatrix();

    // Draw Pie Sections
    fill(#F9FA00, 200);
    stroke(#200101);
    arc(center_x, center_y, s1, s1, radians(ang1), radians(ang1 + ang2), PIE);

    fill(#2ecc71, 190);
    stroke(#200101);
    arc(center_x, center_y, s2, s2, radians(ang1), radians(ang1 + ang2), PIE);

    fill(#e74c3c, 190);
    stroke(#200101);
    arc(center_x, center_y, s3, s3, radians(ang1), radians(ang1 + ang2), PIE);
    if(i==11)
     {
       line(text_x, text_y, 950, 500);
       stroke(126); 
     }
  }

  center_x = width/2 + width/6 - 20;
  center_y = height/2 + 40;

  // Top Label
  textAlign(CENTER);
  textSize(26); 
  fill(0, 190);
  text("APRIL 1855 to MARCH 1856", center_x, height/2 - 210);    
  textSize(20); 

  for (int i = 0; i<second.size(); i++) 
  {
    Row r = second.get(i);
    // Calculate Pie Properties
    float s1 = r.a_zymotic_diseases * 2;
    float s3 = r.a_wounds*1.2 * 2;
    float s2 = r.a_other*1.2 * 2;
    float ang1 = i*(360/second.size())-90;
    float ang2 = (360/second.size());   

    // Draw Text Labels
    float highest = max(s1, max(s2, s3));
    float distance = max(80, highest/2 + 10);
    float text_x = center_x + distance * cos(radians(ang1+ang2/2));
    float text_y = center_y + distance * sin(radians(ang1+ang2/2));
    fill(0, 190); 
    textAlign(CENTER);
    pushMatrix();
    translate(text_x, text_y);
    rotate(radians(ang1+ang2/2+90));
    translate(-text_x, -text_y);
    String t = r.mon;
    String m = t.substring(0, t.indexOf(" "));    
    text(m, text_x, text_y);
    popMatrix();

    // Draw Pie Sections
    fill(#F9FA00, 200);
    stroke(#200101);
    arc(center_x, center_y, s1, s1, radians(ang1), radians(ang1 + ang2), PIE);

    fill(#2ecc71, 190);
    stroke(#200101);
    arc(center_x, center_y, s2, s2, radians(ang1), radians(ang1 + ang2), PIE);

    fill(#e74c3c, 190);
    stroke(#200101);
    arc(center_x, center_y, s3, s3, radians(ang1), radians(ang1 + ang2), PIE);
    if (i==0)
    line(950, 500, text_x, text_y);
     
  }

  // Top Label
  textAlign(CENTER);
  textSize(30); 
  fill(0, 200);
  text("DIAGRAM of the CAUSES of MORTALITY\nIN THE ARMY IN THE EAST", width/2, height/2 - 320);    

  // Draw LabelBox
  fill(#F9FA00, 200);
  stroke(#200101);
  rect(width/2 + 660, height/2, 10, 10);
  textSize(20); 
  fill(0, 190);
  textAlign(LEFT, CENTER);
  text("Deaths by Zymotic Diseases", width/2 +680, height/2 + 3);

  fill(#2ecc71, 200);
  stroke(#200101);
  rect(width/2+ 660, height/2 + 20, 10, 10);
  textSize(20); 
  fill(0, 190);
  textAlign(LEFT, CENTER);
  text("Deaths by Other Causes", width/2+680, height/2 + 23);

  fill(#e74c3c, 200);
  stroke(#200101);
  rect(width/2+ 660, height/2 + 40, 10, 10);
  textSize(20); 
  fill(0, 190);
  textAlign(LEFT, CENTER);
  text("Deaths by Wounds", width/2+680 , height/2 + 43);

  noFill();
  stroke(0, 200);
  rect(width/2 + 650, height/2 -10, 280, 70);
  saveFrame("Final.jpg");
}
