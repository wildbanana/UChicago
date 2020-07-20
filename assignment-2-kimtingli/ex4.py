# Exercise 4: Variables And Names

#cars is a variable with value of 100
cars = 100
#space_in_a_car has a value of 4.0; 4 would also work, but by using 4.0, the subsequent variables that involve this variable will have floating point number as their value too.
space_in_a_car = 4.0
#drivers has a value of 30
drivers = 30
#passengers has a value of 90
passengers = 90
#cars_not_driven has a value that equals the value of cars minus the value of drivers
cars_not_driven = cars - drivers
#cars_driven has the same value as drivers
cars_driven = drivers
#carpool_capacity is the value of cars_drive times the value of space_in_a_car
carpool_capacity = cars_driven * space_in_a_car
#average_passengers_per_car is the value of passengers divided by the value assigned to cars_driven
average_passengers_per_car = passengers / cars_driven


print ("There are", cars, "cars available.")
print ("There are only", drivers, "drivers available.")
print ("There will be", cars_not_driven, "empty cars today.")
print ("We can transport", carpool_capacity, "people today.")
print ("We have", passengers, "to carpool today.")
print ("We need to put about", average_passengers_per_car, "in each car.")
