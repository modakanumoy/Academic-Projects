
from car import car
my_new_car = car('audi','a1', 2023)
print(my_new_car.get_descriptive_name())
my_new_car.odometer_reading = 23
my_new_car.read_odometer()

from car import Electric_Car
my_new_car = Electric_Car('tesla','model', 2022)
print(my_new_car.get_descriptive_name())
print (my_new_car.battery_size)

from car import Battery
Exide_battery = Battery(75)
print(Exide_battery.size)

