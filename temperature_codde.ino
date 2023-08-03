#include <Wire.h>
#include <LiquidCrystal_I2C.h>

// Initialize the LCD object with the I2C address (0x27 for most modules)
LiquidCrystal_I2C lcd(0x27, 16, 2);

void setup() {
  // Initialize the LCD module
  lcd.init();
  lcd.backlight();
  
  // Print names
 
  lcd.print("MD. Emran Mir");
   lcd.setCursor(1, 1);
  lcd.print("201400018"); 
  delay(5000); 
  lcd.clear();

  
  lcd.print("Mahfuzul haque");
  lcd.setCursor(1, 1);
  lcd.print("201400013"); 
  delay(3000);
  
  lcd.clear();
  

  
  lcd.print("Md. Mehedi Hasan");
  lcd.setCursor(1, 1);
  lcd.print("201400041");
  delay(3000); 
  lcd.clear();

  // Print temperature label
  lcd.setCursor(0, 0);
  lcd.print("Temperature:");
  Serial.begin(9600);
}

void loop() {
  // Read the analog value from the LM35 sensor
  int sensorValue = analogRead(A0);

  // Convert the analog value to temperature in Celsius
  float temperature = (sensorValue * 5.0 / 1023.0) * 100.0;

  // Print the temperature value to the serial monitor
  Serial.print("Temperature:");
  Serial.print(temperature);
  Serial.println("°C");


 // Display the temperature value on the LCD screen
lcd.setCursor(0, 1); // Adjust the position to align the temperature reading
lcd.print(temperature, 1);
lcd.print(" C");


  // Delay for a second
  delay(1000);
}
