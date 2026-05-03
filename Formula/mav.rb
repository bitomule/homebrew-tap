class Mav < Formula
  desc "Mobile Agent Verifier for iOS Bazel apps"
  homepage "https://github.com/bitomule/mav"
  version "0.0.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-arm64"
      sha256 "2772b431350551b14f267ddc764fd232d5abf23f6cc4a5ec1fde3420a4ce30dd"
    else
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-amd64"
      sha256 "fa05dd8a659f4939b676b6968b9d8d3abe6c7d0ce26a568ff49fbe3013853a20"
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
