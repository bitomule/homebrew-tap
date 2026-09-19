class Mav < Formula
  desc "Mobile Agent Verifier for iOS apps"
  homepage "https://github.com/bitomule/mav"
  version "0.19.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-arm64"
      sha256 "6c2ffc979691d1382eef629ada34790c0c93efb682ab258e8d5679fa69a90349"
    else
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-amd64"
      sha256 "5d293f0566ebbb2cc231f3d99e79e86850c95aef1ca6565844955dd8062380c6"
    end
  end

  def install
    bin.install cached_download => "mav"
    chmod 0755, bin/"mav"
  end

  test do
    assert_match "Mobile Agent Verifier", shell_output("#{bin}/mav")
    assert_match "cmd=doctor", shell_output("#{bin}/mav doctor")
    assert_match "version=#{version}", shell_output("#{bin}/mav --version")
  end
end
