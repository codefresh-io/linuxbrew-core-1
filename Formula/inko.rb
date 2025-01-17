class Inko < Formula
  desc "Safe and concurrent object-oriented programming language"
  homepage "https://inko-lang.org/"
  url "https://releases.inko-lang.org/0.9.0.tar.gz"
  sha256 "311f6e675e6f7ca488a71022b62edbbc16946f907d7e1695f3f96747ece2051f"
  license "MPL-2.0"
  revision 1
  head "https://gitlab.com/inko-lang/inko.git"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "a7f73e96ff5076466770d434090aa1c49316faa2092dda709554a642bab3e292"
    sha256 cellar: :any,                 big_sur:       "ebceafed0b8fb72511c5788fe525ad83e204b9fce30116a76acd560ce6c36ba8"
    sha256 cellar: :any,                 catalina:      "fa964ccada840c98ea19efad5e62cda6f73df789b4b820148c0af2ff3793347e"
    sha256 cellar: :any,                 mojave:        "536ac0253c59601ac2f717af644997e37a6a801879904f99275c4112fb18c83c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7eb07ab6f5a3cddb616dcb8fc6841877ec7d9e8ba5b15581cd5448ba17ded203" # linuxbrew-core
  end

  depends_on "coreutils" => :build
  depends_on "rust" => :build
  depends_on "libffi"

  uses_from_macos "ruby", since: :sierra

  def install
    system "make", "build", "PREFIX=#{libexec}", "FEATURES=libinko/libffi-system"
    system "make", "install", "PREFIX=#{libexec}"
    bin.install Dir[libexec/"bin/*"]
  end

  test do
    (testpath/"hello.inko").write <<~EOS
      import std::stdio::stdout

      stdout.print('Hello, world!')
    EOS
    assert_equal "Hello, world!\n", shell_output("#{bin}/inko hello.inko")
  end
end
