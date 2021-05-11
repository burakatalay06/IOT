#include<ESP8266WiFi.h>
#include<SoftwareSerial.h>
#include<FirebaseArduino.h>
#include<ArduinoJson.h>
#include<ESP8266HTTPClient.h>
#include<DHT.h>
//----------------------------------------
#include <ESP8266WebServer.h>  //kart web portu açsın diye
#include <WiFiManager.h> //wifi yönetebilmek için
#include <DNSServer.h> //dns server yönetebilmek için


#define FIREBASE_HOST "iot-first-f09d6-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "mDgCfzP7Ly1o2eOYcNf87IF6iQTbsmkZxj52XZae"
//kartın modelini 2.5.2 yaptım !


#define DHTPIN 13
#define DHTTYPE DHT11

DHT dht(DHTPIN,DHTTYPE);

bool light;
bool light_1;
bool light_2;
bool light_3;

unsigned long previousMillis = 0;
const long interval = 10000;

void setup() {
  WiFi.mode(WIFI_STA);
  WiFi.disconnect();
  delay(100);
  
  pinMode(5,OUTPUT);//nodeMCU için D1
  pinMode(4,OUTPUT);//nodeMCU için D2
  pinMode(0,OUTPUT);//nodeMCU için D3
  pinMode(2,OUTPUT);//nodeMCU için D4
  
  Serial.begin(115200);
  delay(500);
  WiFiManager wifiManager;
  wifiManager.autoConnect("Smart_House_Wifi");
  
  Serial.println("Connecting...");

  while(WiFi.status() != WL_CONNECTED){
    Serial.println(".");
    delay(500);
    }
  delay(1000);
  Serial.println();
  Serial.println("Connected...");
  Serial.println(WiFi.localIP());
  //Wifiye bağlanacak burada
  Firebase.begin(FIREBASE_HOST,FIREBASE_AUTH);
  dht.begin();

  delay(1000);


}

void readDatas(){
  float h =dht.readHumidity();
  float t = dht.readTemperature();
  Serial.println("temp");
  Serial.println(t);  
  Serial.println("humidity");
  Serial.println(h);  
  Firebase.setFloat("Data/Temperature",t);
  Firebase.setFloat("Data/Humidity",h);
}


void loop() {
  
light=Firebase.getBool("LightState/switch");
light_1=Firebase.getBool("LightState/switch_1");
light_2=Firebase.getBool("LightState/switch_2");
light_3=Firebase.getBool("LightState/switch_3");

Serial.println("light:");
Serial.print(light);
Serial.println("light_1:");
Serial.print(light_1);
Serial.println("light_2:");
Serial.print(light_2);
Serial.println("light_3:");
Serial.print(light_3);


if(light==true){
  digitalWrite(5,HIGH);//D1 bacağı için
  }
  if(light==false){
    digitalWrite(5,LOW);
  }
if(light_1==true){
  digitalWrite(4,HIGH);//D2 bacağı için
  }
  if(light_1==false){
    digitalWrite(4,LOW);
  }
if(light_2==true){
  digitalWrite(0,HIGH);//D3 bacağı için
  }
  if(light_2==false){
    digitalWrite(0,LOW);
  }
if(light_3==true){
  digitalWrite(2,HIGH);//D4 bacağı için
  }
  if(light_3==false){
    digitalWrite(2,LOW);
  }
  
  unsigned long currentMillis = millis();
  if(currentMillis-previousMillis>=interval){
    readDatas();
    previousMillis=currentMillis;
    }
}
