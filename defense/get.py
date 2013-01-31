import restkit

base = 'https://raw.github.com/hakimel/reveal.js/master/'

want = {
    'classList.js': 'lib/js/classList.js',
    'zoom.js': 'plugin/zoom-js/zoom.js',
    'showdown.js': 'plugin/markdown/showdown.js',
    'markdown.js': 'plugin/markdown/markdown.js',
    'head.min.js': 'lib/js/head.min.js',
    'reveal.js': 'js/reveal.js',
    'reveal.css': 'css/reveal.css',
    'theme-default.css': 'css/theme/default.css',
    'notes.js': 'plugin/notes/notes.js',
}


for target in want:
    print target
    response = restkit.request(base + want[target])
    body = response.body_string()
    with open('vendor/' + target, 'w') as fp:
        fp.write(body)
