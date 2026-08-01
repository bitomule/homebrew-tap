class Simpool < Formula
  desc "iOS simulator pool broker with flock-guarded slots"
  homepage "https://github.com/bitomule/simpool"
  version "0.3.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-arm64"
      sha256 "98dea0cfd16203997bbc3ca2b2368b3113d1e924bbd062ce1d975518760cc99b"
    else
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-amd64"
      sha256 "a0cd1dc1b9bc6d77523662d502792b47b5da6f7be6acc4041efd0c08d2247a99"
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
