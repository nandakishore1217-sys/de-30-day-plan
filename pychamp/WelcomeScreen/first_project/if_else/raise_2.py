try:
    product_name = input("enter the product name")
    product_price = float(input("enter the product price"))
    if product_price <0:
        raise ValueError ("entered price is not valied")
except ValueError as e:
    print(e)

else:
    print(f"product_name: {product_name},product_price : {product_price}")
finally:
    print(" prog completed succesfully")



