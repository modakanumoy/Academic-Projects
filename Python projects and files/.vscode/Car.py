class car:
    def __init__(self,make,model,year):
        self.make = make
        self.model = model
        self.year = year
        self.odometer_reading = 0
    def get_descriptive_name(self):
        model_name = f"{self.year} {self.make} {self.model}"
        return model_name.title()
    def read_odometer(self):
        print(f"This car has {self.odometer_reading} miles on it.")
    def update_odometer(self,milage):
        self.odometer_reading = milage
    def increment_odometer(self,miles):
        self.odometer_reading += miles

class Electric_Car(car):
    def __init__(self,make,model,year):
        super().__init__(make,model,year)
        self.battery_size = 75
    def describe_the_battery(self):
        print(f"This car has {self.battery_size} battery size.")
    def fill_gas_tank(self):
      print("This car doest need a Gas tank")      
my_tesla = Electric_Car('tesla','model', 2022)
print(my_tesla.get_descriptive_name())
my_tesla.describe_the_battery()

class Battery:
    def __init__(self, name):
        self.name = name
        self.size = 75