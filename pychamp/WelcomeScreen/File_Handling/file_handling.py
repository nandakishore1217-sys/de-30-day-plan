from pathlib import Path

customer_file = Path("Data")/"customer.txt"

print(customer_file)
print(customer_file.exists())

content = customer_file.write_text("hello world")

with open("Data/customer.txt","r") as file:
    print(file.read())



