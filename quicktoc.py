import re
toc = open("document.toc")
MATCH = re.compile(r" {([\d.]+)}(?P<name>.*?)([ ]?\(\s*(?P<number>\d+).*)?{\d+}")
numbers = []
for line in toc:
    if 'chapter' not in line:
        continue
    match =MATCH.search(line)
    if not match:
        print line
        continue
    number = match.group('number')
    print match.group(1), number, match.group('name')
    numbers.append(int(number) if number is not None else 0)


print 'gesammt', sum(numbers)



