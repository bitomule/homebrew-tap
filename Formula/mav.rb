class Mav < Formula
  desc "Mobile Agent Verifier for iOS Bazel apps"
  homepage "https://github.com/bitomule/mav"
  version "0.0.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-arm64"
      sha256 "0ece537c36f4b5f95c5e5900942c85f04405169b74b8efcbd50a164bf0435150"
    else
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-amd64"
      sha256 "aebc450a7785bfc5abcceb940d4ca0619addbc07269ac099134dbd9282d644e3"
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
