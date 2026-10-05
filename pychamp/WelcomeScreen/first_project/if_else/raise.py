

##raise means manually triggering an exception when your program detects something invalid.

## this will rasie an exception
try :
    age = int(input("enter the age :"))
    if age < 0:
        raise ValueError("age entered is not correct")
except ValueError as e:
    print(e)

else:
    print(f"valid age : {age}")





