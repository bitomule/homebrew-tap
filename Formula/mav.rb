# Canonical release template. Render with packaging/homebrew/render.py.
class Mav < Formula
  desc "Mobile Agent Verifier for iOS apps"
  homepage "https://github.com/bitomule/mav"
  version "0.35.0"
  depends_on "cameroncooke/axe/axe"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-arm64"
      sha256 "640bd623a47ade130b29cf315bc7924aa55bd2902f1b6a228a4d36b7b23caa21"
    else
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-amd64"
      sha256 "f95599ea79496f37fb31a50f35a01a01cc8385c415ea5b22403a561c95f96398"
    end
  end

  def install
    bin.install cached_download => "mav"
    chmod 0755, bin/"mav"
  end

  test do
    assert_match "Mobile Agent Verifier", shell_output("#{bin}/mav")
    assert_match "version=#{version}", shell_output("#{bin}/mav --version")
  end
end
