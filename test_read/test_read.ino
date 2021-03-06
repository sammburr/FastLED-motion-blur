#include <FS.h>
#include <FastLED.h>

#define NUM_LEDS 121

#define DATA_PIN 0
#define CLOCK_PIN 2

CRGB leds[NUM_LEDS];


char readByte[363];

void setup() {
  Serial.begin(115200);
  LEDS.addLeds<APA102,DATA_PIN,CLOCK_PIN,BGR>(leds,NUM_LEDS);
  LEDS.setBrightness(84);
  delay(2000);
  Serial.println();


  bool success = SPIFFS.begin();
 
  if (!success) {
    Serial.println("Error mounting the file system");
    return;
  }

}

void loop() {
  File file = SPIFFS.open("/image.bin", "r");
 
if (!file) {
    Serial.println("Failed to open file for reading");
    return;
}

  Serial.print("Bytes available: ");
  Serial.println(file.available());


  Serial.println("File Content:");
  int i = NUM_LEDS;
  while (file.available()) {
//    readByte[0] = file.read();
//    readByte[1] = file.read();
//    readByte[2] = file.read();


    //file.readBytes(readByte,3);
    

//    if (readByte[0] <= 0x0F) Serial.print("0");
//    Serial.print(readByte[0],HEX);
//        if (readByte[1] <= 0x0F) Serial.print("0");
//        Serial.print(readByte[1],HEX);
//            if (readByte[2] <= 0x0F) Serial.print("0");
//            Serial.print(readByte[2],HEX);

      file.readBytes( (char*)leds, NUM_LEDS * 3);


      FastLED.show();

//      leds[i] = CRGB( readByte[0], readByte[1], readByte[2]);
//      i --;
//      if (i == 0) {
//         FastLED.show();
//         //delay(10);
//        i = NUM_LEDS;};

  }
 
  file.close();

  delay(250);

    Serial.println("Finished!");

}
