from bronze import bronze
from silver import silver
from gold import gold


Employee_name = input("enter employee name : ")
salary = input("enter the salary: ")
department = input("enter the department: ")

def main():

    output = bronze(Employee_name,salary,department)
    print("bronze:",output)

    output2 = silver(output)
    print("silver: ",output2)


    output3 = gold(output2)
    print("gold :",output3)

main()