def gold(data):
    data["Bonus"]= data["annual_salary"]*0.10 if data["annual_salary"]>=600000 else 0
    data["total_compensation"]= data["annual_salary"]+data["Bonus"]
    return data