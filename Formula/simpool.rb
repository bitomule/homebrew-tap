class Simpool < Formula
  desc "iOS simulator pool broker with flock-guarded slots"
  homepage "https://github.com/bitomule/simpool"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-arm64"
      sha256 "888e13e270189eeb38b4a421053746b1c6d3a164a0b0f23f2fb16823fc68a404"
    else
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-amd64"
      sha256 "777b1bffe9832f1fec04af9b837e09523029302a310ea36005ba3966961f2cdd"
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
