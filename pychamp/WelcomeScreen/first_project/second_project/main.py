from first_project.second_project.bronze import bronze
from first_project.second_project.silver import silver
from first_project.second_project.gold import gold

def main():

    name = input("enter the name: ")
    age = input("enter the age: ")

   #bronze
    data= bronze(name,age)
    print("bronze : " ,data)

    #silver
    data = silver(data)
    print("silver :",data)

    #gold
    data = gold(data)
    print("gold: ",data)

main()