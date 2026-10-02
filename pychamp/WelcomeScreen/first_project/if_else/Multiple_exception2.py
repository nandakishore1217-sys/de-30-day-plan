try:
    number = int(input("enter the number to de divided by : "))
    result = 50/number
    print(f" the result is :,{result}")
except ValueError:
    print(f" the entered type is invalid ")

except ZeroDivisionError :
    print(f" the entered number is : {number}")
