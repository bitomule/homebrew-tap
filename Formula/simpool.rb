class Simpool < Formula
  desc "iOS simulator pool broker with flock-guarded slots"
  homepage "https://github.com/bitomule/simpool"
  version "0.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-arm64"
      sha256 "973e7c92e7be3eb7393ff15cce5292469fcf308cda4554bd61103e25e514d6fc"
    else
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-amd64"
      sha256 "4c6fef7c4e88c1a799a803b40acda9415a452cb4c7af55b15d2535e490127608"
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
