class SopsAT361 < Formula
  desc "Editor of encrypted files"
  homepage "https://github.com/mozilla/sops"
  url "https://github.com/mozilla/sops/archive/v3.6.1.tar.gz"
  sha256 "bb6611eb70580ff74a258aa8b9713fdcb9a28de5a20ee716fe6b516608a60237"
  license "MPL-2.0"
  head "https://github.com/mozilla/sops.git", branch: "develop"

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
