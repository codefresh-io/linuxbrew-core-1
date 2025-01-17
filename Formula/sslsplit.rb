class Sslsplit < Formula
  desc "Man-in-the-middle attacks against SSL encrypted network connections"
  homepage "https://www.roe.ch/SSLsplit"
  url "https://github.com/droe/sslsplit/archive/0.5.5.tar.gz"
  sha256 "3a6b9caa3552c9139ea5c9841d4bf24d47764f14b1b04b7aae7fa2697641080b"
  license "BSD-2-Clause"
  revision 1
  head "https://github.com/droe/sslsplit.git", branch: "develop"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "ccfd4cc54565e58d41ce627ab1ee785de30c96fa29ca3637c3ee6e84320499dc"
    sha256 cellar: :any,                 big_sur:       "4d2d0096b82dfb0104f014f69363a34c1242e2bc32ef585466dc938677c33d26"
    sha256 cellar: :any,                 catalina:      "a533ccfc4c05e2affcfa4c697c38d995239abfd1fe4c383ffaa1a8ed42a933e6"
    sha256 cellar: :any,                 mojave:        "10534d989706ca1d29b7f1cbffc59ef07b02d0d755cb8aec5bdf9430c52769bb"
    sha256 cellar: :any,                 high_sierra:   "4f7a3cb7333641658889a55830a69d0ac64cf93dca8a6de32052d4080f477058"
  end

  depends_on "check" => :build
  depends_on "pkg-config" => :build
  depends_on "libevent"
  depends_on "libnet"
  depends_on "libpcap"
  depends_on "openssl@1.1"

  def install
    ENV["LIBNET_BASE"] = Formula["libnet"].opt_prefix
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    port = free_port

    cmd = "#{bin}/sslsplit -D http 0.0.0.0 #{port} www.roe.ch 80"
    output = pipe_output("(#{cmd} & PID=$! && sleep 3 ; kill $PID) 2>&1")
    assert_match "Starting main event loop", output
  end
end
