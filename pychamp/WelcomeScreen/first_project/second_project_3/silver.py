def silver(data):
    data["name"]= data["name"].strip()
    data["salary"]= int(data["salary"])
    data["department"] = data["department"].lower()
    data["annual_salary"] = data["salary"]*12

    return data