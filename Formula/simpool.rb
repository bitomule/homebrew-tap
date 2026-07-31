class Simpool < Formula
  desc "iOS simulator pool broker with flock-guarded slots"
  homepage "https://github.com/bitomule/simpool"
  version "0.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-arm64"
      sha256 "0e84d44fc031d0b226e74d349aa3ce1e92f9e3524fbba54e103a82b9f7f8467c"
    else
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-amd64"
      sha256 "0a6701e0eb45f1fcd74b79122b427848e1ce31bd3d550d53d17b75656c2fcc1d"
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
