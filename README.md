# Train station simulation

Train station simulation project created for concurrent programming classes in Erlang. 
 
## Projekt description

Project is intended to simulate train station with up to 6 platforms. It shows arrivals and queueing trains on platforms depending on their arrival time. The project simulates a few aspects: train, platform, station. 
It is equivalent to a real-life train station with some platforms and a gear train steering trains into platforms. It has auto and manual mode.

## External libraries

+ wxWidgets

## Processes diagram 

![alt text](https://raw.githubusercontent.com/hechsewa/train-station-simulation/master/imgs/diagram.jpg)

## How to run

Run erlang.
Compile source code in a downloaded folder.
Run train station.

```
erl
cover:compile_directory().
station_server:init().
```

Choose auto or manual mode.

## Screens

Auto mode:

![alt text](https://raw.githubusercontent.com/hechsewa/train-station-simulation/master/imgs/auto_1.jpg)

User's mode:

![alt text](https://raw.githubusercontent.com/hechsewa/train-station-simulation/master/imgs/user_1.jpg)