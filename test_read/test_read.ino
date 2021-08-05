#include <FS.h>

void setup() {
  Serial.begin(115200);
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

  Serial.println("File Content:");
 
  while (file.available()) {
 
    Serial.write(file.read());
  }
 
  file.close();

}

void loop() {
  

}
