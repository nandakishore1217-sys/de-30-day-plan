try:
    number = int(input("enter the number to be divided by : "))
    result = 100/number
    print("result :",result)

except ValueError:
    print("entered number is a valid number")

except ZeroDivisionError:
    print("you cannot divide by zero")
