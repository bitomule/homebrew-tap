class Mav < Formula
  desc "Mobile Agent Verifier for iOS apps"
  homepage "https://github.com/bitomule/mav"
  version "0.5.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-arm64"
      sha256 "64f809b41be43fd1177c9b8eb8fad346777b4068b69d2259e91a9e8bb4df23a5"
    else
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-amd64"
      sha256 "308ce33c4e724a80e17b64a1cb4d3470e8c4f3910cd1a6b96070d3654eb60449"
    end
  end

  def install
    bin.install cached_download => "mav"
    chmod 0755, bin/"mav"
  end

  test do
    assert_match "Mobile Agent Verifier", shell_output("#{bin}/mav")
    assert_match "cmd=doctor", shell_output("#{bin}/mav doctor")
  end
end
