from first_project.first_project.bronse import bronze
from first_project.first_project.silver import silver
from first_project.first_project.gold import  gold

def main():
    name= input("enter your name: ")
    bronze_result= bronze(name)
    print(bronze_result)
    silver_result= silver(name)
    print(silver_result)
    gold_result= gold(name)
    print(gold_result)




    main()