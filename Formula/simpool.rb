class Simpool < Formula
  desc "iOS simulator pool broker with flock-guarded slots"
  homepage "https://github.com/bitomule/simpool"
  version "0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-arm64"
      sha256 "0def78b70503842ad06d9646cf62d9bd3baf6524b308bf691081f6a7ea6dfb57"
    else
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-amd64"
      sha256 "c7d0619a3c1c467ab9a5a6aa7fd913bd5f4235b3da9f76fa6af21a1916df8f9f"
    end
  end

  def install
    bin.install cached_download => "simpool"
    chmod 0755, bin/"simpool"
  end

  test do
    assert_match "simpool", shell_output("#{bin}/simpool status 2>&1", 0)
  end
end
