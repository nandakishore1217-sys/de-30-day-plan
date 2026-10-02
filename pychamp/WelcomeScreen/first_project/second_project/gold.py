def gold(data):
    data["category"]= "adult" if data["age"]>18 else "minor"
    return data