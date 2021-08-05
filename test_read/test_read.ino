#include <FS.h>


long readByte[4];

void setup() {
  Serial.begin(115200);
  delay(2000);
  Serial.println();


  bool success = SPIFFS.begin();
 
  if (!success) {
    Serial.println("Error mounting the file system");
    return;
  }

File file = SPIFFS.open("/apple.bin", "r");
 
if (!file) {
    Serial.println("Failed to open file for reading");
    return;
}

  Serial.print("Bytes available: ");
  Serial.println(file.available());


  Serial.println("File Content:");

  while (file.available()) {

    readByte[0] = file.read();
    readByte[1] = file.read();
    readByte[2] = file.read();
    readByte[3] = file.read();

    Serial.print(readByte[0],HEX);
        Serial.print(readByte[1],HEX);
            Serial.print(readByte[2],HEX);
                Serial.println(readByte[3],HEX);
  }
 
  file.close();

    Serial.println("Finished!");

}

void loop() {
  

}
