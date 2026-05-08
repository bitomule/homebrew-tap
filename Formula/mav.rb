class Mav < Formula
  desc "Mobile Agent Verifier for iOS apps"
  homepage "https://github.com/bitomule/mav"
  version "0.2.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-arm64"
      sha256 "cc89a81ceac6976b0dead36f83d1a40028cfc471d89434d2bd39f554ae685068"
    else
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-amd64"
      sha256 "27423e7a588a1b1100535821f23ff965a9da8d6557c9d4dd4bbda8f47fc465bc"
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
