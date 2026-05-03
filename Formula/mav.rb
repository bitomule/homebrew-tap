class Mav < Formula
  desc "Mobile Agent Verifier for iOS Bazel apps"
  homepage "https://github.com/bitomule/mav"
  version "0.0.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-arm64"
      sha256 "c04c9d9bd63e632a6fd7c43961c7427767bdbe1cd71ff30a0161c532ebfafafa"
    else
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-amd64"
      sha256 "ce842bdafce59a373f95a84b05b43c6d23eb4746f7aaa8c351e45c46cc8f7d80"
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
