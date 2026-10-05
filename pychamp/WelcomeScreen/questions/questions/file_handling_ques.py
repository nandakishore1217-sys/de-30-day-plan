from collections import Counter
## Q7


with open("customer.txt","w") as file:
    file.write("John,25 \nAlice,30 \nBob,28")


with open("customer.txt","r") as file:
   print(file.read())
   file.seek(0)
   print(file.readline())
   file.seek(0)
   print(file.readlines())


##Q11

count = 0
with open("customer.txt","r") as file:
    for line in file:
        count+=1

print(count)


##Q12
with open("customer.txt","r") as file:
    text = file.read()
    word = text.split()
    count = len(word)
print(count)

##13

with open("customer.txt","r")as file:
    text = file.read()
    count = len(text)
print(count)


##Q14
count =0

with open("customer.txt","r") as file:
    text = file.read()
    for char in text:
        if char.lower() in "aeiou":
            count+=1


print("the vowels are",count)




##Q15

with open("customer.txt","r") as file:
    text  = file.read()
    word  = text.split()
    longest_word = max(word,key=len)
    short_word = min(word,key=len)
print( "the longest world",longest_word)
print("the shortest word ",short_word)


##Q17
with open("customer.txt","r") as file:
    text = file.read()
    if "Alice" in text:
        print("Alice found")
    else:
        print("Alice not found")


##Q18
with open("customer.txt","r")as file:
    text = file.read()
    count=text.count("Alice")
    print(count)



##Q19

with open("customer.txt","r") as source:
   text= source.read()


with open("back_up.txt","w") as destination:
    destination.write(text)

with open("back_up.txt","r")as file:
    print(file.read())

##Q21


with open("back_up.txt","a") as file:
    file.write("\napple,\nbanana, \napple, \napple, \nbanana")


with open("back_up.txt","r") as file:
    print(file.read())



with open("back_up.txt","r")as file:
    text = file.read()
    word = text.split()
    word_count = Counter(word)
    print(word_count)
    counts=word_count.most_common(3)
    print(counts)


with open("new_file.txt","w")as file:
    file.write("John,25,\n\nAlice,30,\n\nBob,28")


with open("new_file.txt","r")as source:
    with open("cleaned_txt","w") as destination:
        for line in source:
            if line.strip():
                destination.write(line)



with open("cleaned_txt","r")as file:
    print(file.read())



##Q23

seen =set()

with open("cleaned_txt","r") as source:
    with open("unique_lines","w") as destination:
        for line in source:
            line = line.strip()

            if line not in seen:
                seen.add(line)
                destination.write(line+"\n")


print("================ ")


with open("unique_lines","r")as file:
    print(file.read())


