import sys
from threading import Thread,Event

import json
import random
import datetime,time

from paho.mqtt import client as mqtt_client

# Import the required library
from geopy.geocoders import Nominatim

# Initialize Nominatim API
geolocator = Nominatim(user_agent="MyApp")

location = geolocator.geocode("hangzhou")

print("The latitude of hangzhou is: ", location.latitude)
print("The longitude of hangzhou is: ", location.longitude)


broker = 'broker.emqx.io'
port = 1883
topic = "crerlu/bs/mqtt"
# generate client ID with pub prefix randomly
client_id = f'python-mqtt-{random.randint(0, 1000)}'
stopAllThreads = Event()

class Message:
    def __init__(self, alert, info, latitude, longitude, timestamp, value, device_id):
        self.alert = alert
        self.info = info
        self.latitude = latitude
        self.longitude = longitude
        self.time_stamp = timestamp
        self.value = value
        self.device_id = device_id

    def toJSON(self):
        return json.dumps(self.__dict__)

def connect_mqtt():
    def on_connect(client, userdata, flags, rc):
        if rc == 0:
            print("Connected to MQTT Broker!")
        else:
            print("Failed to connect, return code %d\n", rc)

    client = mqtt_client.Client(client_id)
    client.on_connect = on_connect
    client.connect(broker, port)
    return client


def publish(stopAllThreads : Event, client, device_id):
    while True:
        if stopAllThreads.is_set():
            break
        time.sleep(1)
        alert = random.randint(0, 1)
        info = "device " + device_id + " is " + ("normal" if alert == 0 else "abnormal")
        latitude = location.latitude + random.uniform(-0.1, 0.1)
        longitude = location.longitude + random.uniform(-0.1, 0.1)
        time_stamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        value = random.randint(0, 100)
        msg = Message(alert, info, latitude, longitude, time_stamp, value, device_id).toJSON()
        print("device " + str(device_id) + " is sending random message: " + msg)
        result = client.publish(topic, msg)
        status = result[0]
        if status == 0:
            print(f"Send `{msg}` to topic `{topic}`")
        else:
            print(f"Failed to send message to topic {topic}")


def run(stopAllThreads : Event, device_id):
    client = connect_mqtt()
    client.loop_start()
    publish(stopAllThreads, client, device_id)


if __name__ == '__main__':
    stopAllThreads = Event()
    device_id_list = []
    for i in range(1, len(sys.argv)):
        device_id_list.append(sys.argv[i])
    threads = []
    for device_id in device_id_list:
        print("starting to mock device " + device_id + " ...")
        t = Thread(target=run, args=(stopAllThreads, device_id))
        t.start()
        threads.append(t)

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        # 当捕获到Ctrl+C，设置事件来通知线程停止
        print("Caught KeyboardInterrupt, stopping threads.")
        stopAllThreads.set()

        # 确保所有线程都已经停止
        for t in threads:
            t.join()
    
    print("all_threads_done")
    
