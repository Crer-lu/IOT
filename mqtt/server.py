from paho.mqtt import client as mqtt_client
import pymysql
import os, json
from omegaconf import OmegaConf
import random

# config file
conf = OmegaConf.load("config.yaml")

# mysql database connection
conn = pymysql.connect(host=conf.database.ip, port=int(conf.database.port), user=conf.database.user, password=conf.database.password, db=conf.database.database)
cursor = conn.cursor()
# mysql database connection checker
def checkConn():
    global conn, cursor
    try:
        conn.ping()
    except:
        conn = pymysql.connect(host=conf.database.ip, port=int(conf.database.port), user=conf.database.user, password=conf.database.password, db=conf.database.database)
        cursor = conn.cursor()
        
# mqtt config
broker = 'broker.emqx.io'
port = 1883
topic = 'crerlu/bs/mqtt'
client_id = f'python-mqtt-{random.randint(0, 1000)}'

def connect_mqtt():
    def on_connect(client, userdata, flags, rc):
        if rc == 0:
            print("Connected to MQTT Broker!")
        else:
            print("Failed to connect, return code %d\n", rc)
    # Set Connecting Client ID
    client = mqtt_client.Client(client_id)
    client.on_connect = on_connect
    client.connect(broker, port)
    return client

def subscribe(client: mqtt_client):
    def on_message(client, userdata, msg):
        print(f"Received `{msg.payload.decode()}` from `{msg.topic}` topic")
        ## insert data to database
        dict = json.loads(msg.payload.decode())
        checkConn()
        sql = "INSERT INTO message (alert, info, latitude, longitude, time_stamp, value, device_id) VALUES (%s, %s, %s, %s, %s, %s, %s)"
        val = (dict["alert"], dict["info"], dict["latitude"], dict["longitude"], dict["time_stamp"], dict["value"], dict["device_id"])
        cursor.execute(sql, val)
        conn.commit()
        print(cursor.rowcount, "record inserted.")

    client.subscribe(topic=topic, qos=0)
    client.on_message = on_message

def unsubscribe(client: mqtt_client):
    client.on_message = None
    client.unsubscribe(topic)

def run():
    client = connect_mqtt()
    subscribe(client)
    client.loop_forever()


if __name__ == '__main__':
    run()