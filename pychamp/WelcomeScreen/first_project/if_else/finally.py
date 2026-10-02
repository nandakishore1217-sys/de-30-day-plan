try:
    file = open("data.txt","r")
    data=file.read()
    print(data)

except FileExistsError:
    print("file does not exist")

finally:
    print("file operation closed")


##finally is used when cleanup is need to be done  ie , to close the file at the end of the prog
## to close a database connection
## release a resource
## to clean upa an temperory resource


