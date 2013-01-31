import restkit


want = {
    'vendor/reveal.js': 'https://raw.github.com/hakimel/reveal.js'
                        '/blob/master/js/reveal.js',
}


for target in want:
    response = restkit.request(want[target])
    body = response.body_string()
    with open(target, 'w') as fp:
        fp.write(body)
