
class InvalidAgeError(Exception):
    pass


try:
    age = int(input("enter the age"))
    if age < 0:
        raise InvalidAgeError(" entered age is wrong")

except InvalidAgeError:
    print(" not valid age entered")

except ValueError as e :
    print( e)
else:
    print(f"valid age entered: {age}")

finally :
    print("age validation completed");


