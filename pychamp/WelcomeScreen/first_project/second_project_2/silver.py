def silver(data):
    data["product_name"] = data["product_name"].strip()
    data["price"]= int(data["price"])
    data["quantity"] = int(data["quantity"])
    data["sub_total"] = data["price"]*data["quantity"]

    return data