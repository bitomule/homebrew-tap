class Simpool < Formula
  desc "iOS simulator pool broker with flock-guarded slots"
  homepage "https://github.com/bitomule/simpool"
  version "0.9.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-arm64"
      sha256 "ba5296c8c1a818dabf8bc8dcd166e773026d260c44450d48688c1d5bb2fa23fc"
    else
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-amd64"
      sha256 "276dd2e08ab951dd580188167a1ea4958fb725c318a7c25d473f407b0326d859"
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
