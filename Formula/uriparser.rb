class Uriparser < Formula
  desc "URI parsing library (strictly RFC 3986 compliant)"
  homepage "https://uriparser.github.io/"
  url "https://github.com/uriparser/uriparser/releases/download/uriparser-0.9.5/uriparser-0.9.5.tar.bz2"
  sha256 "dd8061eba7f2e66c151722e6db0b27c972baa6215cf16f135dbe0f0a4bc6606c"
  license "BSD-3-Clause"
  head "https://github.com/uriparser/uriparser.git", branch: "master"

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "3506704f47f1a78c9bb09c8b95fb5a0d3a99f6d0b55d8d9537ed1d3ce1d2dd0a"
    sha256 cellar: :any,                 big_sur:       "850d83c937b7bef0e5008f58ecee310a788cd0e3a450e8d2f86eae406c2c82d4"
    sha256 cellar: :any,                 catalina:      "aa27111b6106992b4324389e45bef8fc4da6bcba0ceaa94d867eeb320680e71c"
    sha256 cellar: :any,                 mojave:        "b5c0c029eaf64eb39cd4b67be8fff8fff2ccb4dac09cda0bf42bbabd0ab39b3b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b9bbdf8356d6eacc483b962e3dfa19e1a933ae0f1db681d5675e6c6ba1f81c72" # linuxbrew-core
  end

  depends_on "cmake" => :build

  conflicts_with "libkml", because: "both install `liburiparser.dylib`"

  def install
    system "cmake", ".", "-DURIPARSER_BUILD_TESTS=OFF",
                         "-DURIPARSER_BUILD_DOCS=OFF",
                         "-DCMAKE_INSTALL_RPATH=#{rpath}",
                         *std_cmake_args
    system "make"
    system "make", "install"
  end

  test do
    expected = <<~EOS
      uri:          https://brew.sh
      scheme:       https
      hostText:     brew.sh
      absolutePath: false
                    (always false for URIs with host)
    EOS
    assert_equal expected, shell_output("#{bin}/uriparse https://brew.sh").chomp
  end
end
