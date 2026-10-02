def silver(data):
    data["name"]= data["name"].strip()
    data["age"]= int(data["age"])
    return data