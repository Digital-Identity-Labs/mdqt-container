# MDQT Container - A Metadata Query Tool (in a container)

This project wraps a 20k utility written in Ruby inside an entire portable
OS, which feels rather ridiculous but may be useful for people who
can install Docker but who don't want to bother with a Ruby and
C development environment.

## MDQT?
MDQT is small library and commandline tool to query MDQ services for SAML metadata.
You could do this with `curl` and `xmlsec1` but it's a little more convenient to use `mdqt` instead.

MDQ currently supports:

  - Downloading single entities, lists or aggregates
  - Signature verification
  - Saving metadata to disk
  - Caching entity metadata on disk
  - Gzip compression

## MDQ?

MDQ is a simple HTTP-based standard for looking up individual SAML entity metadata. Rather than regularly
downloading large metadata aggregates containing thousands of entity descriptions,
an IdP or SP can download the metadata for an individual entity whenever it is needed.

The UK Access Management Federation has a
[useful page explaining MDQ](https://www.ukfederation.org.uk/content/Documents/MDQ)

## Installation

Quick alias to run only with built in files, outputting to STDOUT and STDERR

    $ alias mdq="docker run --rm digitalidentity/mdqt"

Then run with a relatively normal mdqt command (after a delay the first time)

    $ mdq get --cache --verbose --verify-with example.pem {sha1}52e2065fc0d53744e8d4ee2c2f30696ebfc5def9

That's it!

To access new certificates (you should use new certificates) and write files
you will need to mount your current working directory at /opt/app in the container:

    $ alias mdq="docker run -v $PWD:/opt/app --rm digitalidentity/mdqt"
    $  mdq get --cache --verbose --verify-with my_cheked_cert.pem --save-to md [sha1]52e2065fc0d53744e8d4ee2c2f30696ebfc5def9

If you are always using the same MDQ server you should specify it with an
environment variable.

    $ alias mdq="docker run -e MDQT_SERVICE='http://mdq-beta.incommon.org/global' --rm digitalidentity/mdqt"

## Using MDQT

[Full instructions](https://github.com/Digital-Identity-Labs/mdqt/blob/master/README.md) are
available at the [main MDQT repository](https://github.com/Digital-Identity-Labs/mdqt).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Digital-Identity-Labs/mdqt.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
