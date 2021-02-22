with open('lata.txt') as f:
    lines = f.read().splitlines()
for j in range(len(lines)):
    mstr = lines[j]
    outstr = ""
    for i in range(len(mstr)):
        if (mstr[i].islower()) or (mstr[i].isdigit())  or mstr[i] == '.' :
            outstr = outstr+mstr[i]
        else:
            outstr = outstr+" "+mstr[i]    
    print outstr
