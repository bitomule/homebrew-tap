# Canonical release template. Render with packaging/homebrew/render.py.
class Mav < Formula
  desc "Mobile Agent Verifier for iOS apps"
  homepage "https://github.com/bitomule/mav"
  version "0.34.0"
  depends_on "cameroncooke/axe/axe"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-arm64"
      sha256 "4ff9e632bc6012979a70da77ef39ff41495eec275d58223118526cd73f39b885"
    else
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-amd64"
      sha256 "de418c1034efb8c11f8194606aba6f9e07097ac4067b0ac75a8c9bbb1a10314d"
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
