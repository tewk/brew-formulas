require 'formula'

class Cxxtest < Formula
  homepage 'http://cxxtest.com'
  url 'https://github.com/CxxTest/cxxtest/archive/4.3.tar.gz'
  sha1 'f0ec223e19e153add782200d3a8a9b710a9f8f5a'

  head 'https://github.com/CxxTest/cxxtest.git', :branch => 'master'

  def install
    libexec.install Dir['*']
    bin.install_symlink "#{libexec}/bin/cxxtestgen"
    include.install_symlink "#{libexec}/cxxtest"
  end
end
