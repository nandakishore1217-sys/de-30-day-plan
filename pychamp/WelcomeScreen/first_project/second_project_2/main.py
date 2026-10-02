from first_project.second_project_2.bronze import bronze
from first_project.second_project_2.silver import silver
from first_project.second_project_2.gold import gold

product_name = input("enter the product name : ")
price = input("enter the price")
quantity = input("enter the quantity: ")


def main():

    output = bronze(product_name,price,quantity)
    print("output is :",output)


    output2 = silver(output)
    print("silver :",output2)


    output3 = gold(output2)
    print("gold:", output3)


main()

