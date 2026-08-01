class Simpool < Formula
  desc "iOS simulator pool broker with flock-guarded slots"
  homepage "https://github.com/bitomule/simpool"
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-arm64"
      sha256 "dac3975603f29035ebfa764184e743c5c1fe4142a4742f5cda5505462add5a7b"
    else
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-amd64"
      sha256 "4b0986e31bec21c10f473f2541016e5e45320f9ffddf14c047e000457b5723c7"
    end
  end

  def install
    bin.install cached_download => "simpool"
    chmod 0755, bin/"simpool"
  end

  test do
    assert_match "SLOT", shell_output("#{bin}/simpool status")
  end
end
