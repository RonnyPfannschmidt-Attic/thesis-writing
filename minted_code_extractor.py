import py
import sys

REGEX = py.std.re.compile(r'\\mintedfromtexofcode\{(.*)}{(.*)}')


TEMPLATE = r"""
\begin{minted}[linenos, firstnumber=%(num)d]{python}
missing = %(name)s
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


def run(content, code, target):
    parts = []
    for texfile in content.visit("*.tex"):
        parts.extend(codeparts(texfile))

    mapping = dict(parts)
    assert len(mapping) == len(parts)
    
    for targetname in mapping:
        code = TEMPLATE % {
            'name': targetname.replace('_', '\_'),
            'num': 0,
            'code': mapping[targetname],
        }
        target.join(targetname+'.tex').write(code)

if __name__ == '__main__':
        
    content = py.path.local(sys.argv[1])
    code = py.path.local(sys.argv[2])

    target = py.path.local(sys.argv[3])
    target.ensure(dir=1)
    run(content, code, target)
