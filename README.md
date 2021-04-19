# LaTeXML::Plugin::latexmls

[![Build Status](https://github.com/dginev/LaTeXML-Plugin-latexmls/workflows/CI/badge.svg)](https://github.com/dginev/LaTeXML-Plugin-latexmls/actions?query=workflow%3ACI)
[![license](http://img.shields.io/badge/license-Unlicense-blue.svg)](https://raw.githubusercontent.com/dginev/LaTeXML-Plugin-latexmls/master/LICENSE)
[![CPAN version](https://badge.fury.io/pl/LaTeXML-Plugin-latexmls.svg)](https://badge.fury.io/pl/LaTeXML-Plugin-latexmls)

A minimal socket server for daemonized LaTeXML processing

## Installation

Just another Perl module. Use either the modern `cpanm .` or the classic:

```bash
perl Makefile.PL ; make ; make test; sudo make install
```

Make sure that LaTeXML has been installed prior to installing this Plugin, as well as all modules reported missing by Makefile.PL.

## Example use

See the casual author use pattern by the [latexmlc](https://github.com/brucemiller/LaTeXML/blob/master/bin/latexmlc#L123) executable of LaTeXML.

On a generic level, `latexmls` takes an HTTP request and returns a JSON payload. This can be illustrated with a minimal curl example:

1. Start a server process on some available port, and specify the allowed inactivity before it automatically shuts down.

    ```bash
    latexmls --port=43434 --expire=60
    ```

2. Initialize a new cached conversion profile, using the `cache_key` capability with a mock conversion call. Specify all configuration you would typically provide for latexml/latexmlpost here.

    ```bash
    curl http://localhost:43434 -o payload.json -d \
    'cache_key=eg&preload=article.cls&preload=texvc.sty&whatsin=math&whatsout=math&format=html5&source=literal:1'
    ```

3. Use the cached profile for real conversions.

    ```bash
    curl http://localhost:43434 -o payload.json -d 'cache_key=eg&source=literal:\sqrt{x}>0'
    ```

    Note that latexmls expects proper [url encoding](https://en.wikipedia.org/wiki/Percent-encoding) if you're assembling your HTTP requests by hand, e.g. `\sqrt{x}` needs to be transmitted as `%5Csqrt%7Bx%7D`. This is done automatically by the curl `-d` flag in the example above.

4. The returned json payload (indented for readability here) for this configuration should look along the lines of:

    ```json
    {
      "status": "No obvious problems",
      "log": "...Status:conversion: 0 ",
      "status_code": 0,
      "result": "<math ...</math>"
    }
    ```

## Known current uses of latexmls

* [Authorea](https://www.authorea.com/) via the [latexml-ruby](https://github.com/Authorea/latexml-ruby/) wrapper, since 2017
* [latexml-runner](https://github.com/dginev/latexml-runner), a local harness for converting large collections, since 2021. Also offers a generic Rust wrapper.

## Alternatives

See also the [ltxmojo](https://github.com/dginev/LaTeXML-Plugin-ltxmojo/) web showcase which uses a proper web service framework, as a potential alternative or inspiration for bundling LaTeXML into your web framework of choice.
