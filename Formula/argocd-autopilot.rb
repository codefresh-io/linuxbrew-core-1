class ArgocdAutopilot < Formula
  desc "Opinionated way of installing Argo CD and managing GitOps repositories"
  homepage "https://argoproj.io"
  url "https://github.com/argoproj-labs/argocd-autopilot.git",
      tag:      "v0.1.10",
      revision: "646b3faa598281d0404c4b85443361597173c6c7"
  license "Apache-2.0"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "888e1d9819424e8b4e199883aa5bbddc497e656eaebb85768cb8ae2d8397b9fb"
  end

  depends_on "go" => :build

  def install
    system "make", "cli-package"
    bin.install "dist/argocd-autopilot"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/argocd-autopilot version")
    assert_match "authentication failed",
                 shell_output("#{bin}/argocd-autopilot repo create -o foo -n bar -t dummy 2>&1", 1)
  end
end