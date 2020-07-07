class Libdaemon < Formula
  desc "C library that eases writing UNIX daemons"
  homepage "http://0pointer.de/lennart/projects/libdaemon/"
  url "http://0pointer.de/lennart/projects/libdaemon/libdaemon-0.14.tar.gz"
  sha256 "fd23eb5f6f986dcc7e708307355ba3289abe03cc381fc47a80bca4a50aa6b834"
  license "LGPL-2.1"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "ad96f0b0e09c3e0c178d3e903659d65ae34fea18365197924a4911c291d02531" => :catalina
    sha256 "1fe52d810eca4471b4d285de02a09ea9e4b78d762f1a2a292d6da1eb10e9626d" => :mojave
    sha256 "0933bb1dde0237f4079fefcd228ea644be36fbf814aa96762ebbae3537886558" => :high_sierra
    sha256 "26283261454649e12e8060adcfe6e4e4d80d6c65d6ecfc4a6b0c706bfc65f0d2" => :x86_64_linux
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
