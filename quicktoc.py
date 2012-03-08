toc = open("document.toc")
numbers = []
for line in toc:
    if 'chapter' not in line:
        continue
    numberline = line.split('}{')[1]
    data = numberline.split('}', 1)
    if data[0][-1].isdigit():
        numbers.append(int(filter(str.isdigit, data[1])))
    print data[-1]

print 'gesammt', sum(numbers)



