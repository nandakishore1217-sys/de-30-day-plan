try:
    salary = float(input("enter the Monthly salary amount : "))
except ValueError:
    print( "entered type is not valid,please enter an valid salary")
else:
    Annual_salary= salary*12
    Annual_bouns = Annual_salary *0.10
    total_componsation = Annual_salary+Annual_bouns
    print(f"annual_salary :{Annual_salary} \n Annual_bonus {Annual_bouns} \n Total_componsation {total_componsation}")



