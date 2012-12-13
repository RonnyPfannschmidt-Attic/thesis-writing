import py
D = 'deffeat'

content = py.path.local('content')
for path in content.listdir('*.tex'):
    for line in path.readlines():
        try:
            index = line.index(D)
        except ValueError:
            continue

        line = line[index + len(D) + 1 :line.index('}', index)]
        print r"\reffeat{%s}" % line
