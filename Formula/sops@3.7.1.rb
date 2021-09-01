class SopsAT371 < Formula
  desc "Editor of encrypted files"
  homepage "https://github.com/mozilla/sops"
  url "https://github.com/mozilla/sops/archive/v3.7.1.tar.gz"
  sha256 "536ee140d888b53b71c1e8edd669f4c11bc573428983fbea644fbbfcd7d7079a"
  license "MPL-2.0"
  head "https://github.com/mozilla/sops.git", branch: "master"

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/"sops", "go.mozilla.org/sops/v3/cmd/sops"
    pkgshare.install "example.yaml"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sops --version")

    assert_match "Recovery failed because no master key was able to decrypt the file.",
      shell_output("#{bin}/sops #{pkgshare}/example.yaml 2>&1", 128)
  end
end
