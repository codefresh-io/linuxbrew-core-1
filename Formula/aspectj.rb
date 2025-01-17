class Aspectj < Formula
  desc "Aspect-oriented programming for Java"
  homepage "https://www.eclipse.org/aspectj/"
  url "https://github.com/eclipse/org.aspectj/releases/download/V1_9_7/aspectj-1.9.7.jar"
  sha256 "c6b83cf272ce71a81a02c1529e760286196fe842a1741aa42494c3ce1501bd3a"
  license "EPL-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:_\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5f94378ed79ac6d24889ebf3b40df02d159988c8673fb55c54997bc89ff46895"
    sha256 cellar: :any_skip_relocation, big_sur:       "f0ae7be29aa7df4960f1ae71a30f9ce57d9c28300591deb042b68fb439157ec8"
    sha256 cellar: :any_skip_relocation, catalina:      "445830c663aa8379176a05874f3689c13ebaf953e50afe8e193322353db9d4aa"
    sha256 cellar: :any_skip_relocation, mojave:        "751669f59894109ea55f8d8a22ded54b459f20505f74c33fd57fc9b47de36b26"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7e6fcaaf002adcf9e6fab54538e49990d16fbfca74334f6d6728ac72f14f2cce" # linuxbrew-core
  end

  depends_on "openjdk"

  def install
    mkdir_p "#{libexec}/#{name}"
    system "#{Formula["openjdk"].bin}/java", "-jar", "aspectj-#{version}.jar", "-to", "#{libexec}/#{name}"
    bin.install Dir["#{libexec}/#{name}/bin/*"]
    bin.env_script_all_files libexec/"#{name}/bin", Language::Java.overridable_java_home_env
    chmod 0555, Dir["#{libexec}/#{name}/bin/*"] # avoid 0777
  end

  test do
    (testpath/"Test.java").write <<~EOS
      public class Test {
        public static void main (String[] args) {
          System.out.println("Brew Test");
        }
      }
    EOS
    (testpath/"TestAspect.aj").write <<~EOS
      public aspect TestAspect {
        private pointcut mainMethod () :
          execution(public static void main(String[]));

          before () : mainMethod() {
            System.out.print("Aspect ");
          }
      }
    EOS
    ENV["CLASSPATH"] = "#{libexec}/#{name}/lib/aspectjrt.jar:test.jar:testaspect.jar"
    system bin/"ajc", "-outjar", "test.jar", "Test.java"
    system bin/"ajc", "-outjar", "testaspect.jar", "-outxml", "TestAspect.aj"
    output = shell_output("#{bin}/aj Test")
    assert_match "Aspect Brew Test", output
  end
end
