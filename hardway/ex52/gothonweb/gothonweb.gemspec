lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "NAME"
  spec.version       = '1.0'
  spec.authors       = ["Yahui Wang"]
  spec.email         = ["wangyh@brandeis.edu  "]
  spec.summary       = %q{ex46}
  spec.description   = %q{null}
  spec.homepage      = "http://domainforproject.com/"
  spec.license       = "B"

  spec.files         = ['lib/NAME.rb']
  spec.executables   = ['bin/NAME']
  spec.test_files    = ['tests/test_NAME.rb']
  spec.require_paths = ["lib"]
end

