import restkit

base = 'https://raw.github.com/hakimel/reveal.js/master/'

want = {
    'vendor/head.min.js': 'lib/js/head.min.js',
    'vendor/reveal.js': 'js/reveal.js',
    'vendor/reveal.css': 'css/reveal.css',
    'vendor/theme-default.css': 'css/theme/default.css',
}


for target in want:
    print target
    response = restkit.request(base + want[target])
    body = response.body_string()
    with open(target, 'w') as fp:
        fp.write(body)
