try:
    account_balance = float(input("enter your account balance"))
    withdraw_amount= float(input("enter the withdrawal amount"))

except ValueError:
    print( "invalied  amount entered ")

else:
    if withdraw_amount > account_balance :
        print("Insufficient balance")
    else:
        balance = account_balance-withdraw_amount
        print(f"balance amount is : {balance}")

finally:
    print("transaction completed")
