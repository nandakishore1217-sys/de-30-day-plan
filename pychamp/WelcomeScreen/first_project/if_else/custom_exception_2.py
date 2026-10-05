class InvalidSalaryError(Exception):
    pass

try:
    emp_name = input("enter Employee name")
    month_sal = float(input("enter monthly sal"))
    if month_sal < 0:
        raise InvalidSalaryError("entered salary amount is wrong")

except InvalidSalaryError as e:
    print(e)
except ValueError as e:
    print(e)
else:
    anul_sal = month_sal*12
    bonus = anul_sal*0.10
    total_comp = anul_sal+ bonus
    print(f"annual_sal :{anul_sal},bonus : {bonus},total_comp : {total_comp}")
finally:
    print("calculation completed")

