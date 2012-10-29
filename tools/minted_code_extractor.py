import py
import sys

REGEX = py.std.re.compile(r'\\mintedfromtexofcode\{(.*)}{(.*)}')


TEMPLATE = r"""
\begin{minted}[linenos, firstnumber=%(num)d]{python}
%(code)s
\end{minted}
""".strip()

def codeparts(path):
    matches = []
    with path.open() as fp:
        for line in fp:
            match = REGEX.search(line)
            if match:
                matches.append(match.group(1,2))
    return matches

def extractfunction(lines, name):
    find = 'def '+name
    for startidx, line in enumerate(lines):
        if find in line:
            break

    endidx = startidx+1
    while lines[endidx+1][0].isspace():
        endidx += 1

    while not lines[startidx-1][0].isspace():
        startidx -= 1

    return startidx, ''.join(lines[startidx:endidx])

def extractfunction_from_path(code, itemname):
    path, funcname = itemname.split(':')
    lines = code.join(path).readlines()
    return extractfunction(lines, funcname)

def run(content, code, target):
    parts = []
    for texfile in content.visit("*.tex"):
        parts.extend(codeparts(texfile))

    mapping = dict(parts)
    assert len(mapping) == len(parts)
    
    for targetname, source in mapping.items():
        num, text = extractfunction_from_path(code, source)
        code = TEMPLATE % {
            'name': targetname.replace('_', '\_'),
            'num': num,
            'code': text,
        }
        target.join(targetname+'.tex').write(code)

if __name__ == '__main__':
        
    content = py.path.local(sys.argv[1])
    code = py.path.local(sys.argv[2])

    target = py.path.local(sys.argv[3])
    target.ensure(dir=1)
    run(content, code, target)
