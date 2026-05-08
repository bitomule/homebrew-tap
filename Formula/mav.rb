class Mav < Formula
  desc "Mobile Agent Verifier for iOS apps"
  homepage "https://github.com/bitomule/mav"
  version "0.2.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-arm64"
      sha256 "13799233a522069880fefc3a66690220d80656912770d72f91e297337e20f6c2"
    else
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-amd64"
      sha256 "8983c1ac84ac0f337718a681b4122b02dc6414fe7ec2cbe94f524d44dd39f42d"
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
