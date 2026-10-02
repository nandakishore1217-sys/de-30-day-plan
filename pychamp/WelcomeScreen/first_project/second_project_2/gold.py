def gold(data):
    data["discount"] = data["sub_total"]*0.10 if data["sub_total"] >=5000 else 0
    data["final_price"] = data["sub_total"]- data["discount"]
    return data