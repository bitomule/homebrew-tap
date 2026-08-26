class Mav < Formula
  desc "Mobile Agent Verifier for iOS apps"
  homepage "https://github.com/bitomule/mav"
  version "0.15.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-arm64"
      sha256 "658e8c008a1d5a9bb5d4fa0562dff4b1af32770259fe29786fb9f8d3270dfc47"
    else
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-amd64"
      sha256 "9754affef5f028a49f2cc795fe712481de36b515fc9f90f3a2331486915d8f00"
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
