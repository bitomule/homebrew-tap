class Simpool < Formula
  desc "iOS simulator pool broker with flock-guarded slots"
  homepage "https://github.com/bitomule/simpool"
  version "0.13.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-arm64"
      sha256 "cf60c6bf3d102680f1c7959337b7ae133ed349371f6137bb7d5c4f19327ed793"
    else
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-amd64"
      sha256 "efe384c7b4b5ab883a2c192e33639c46ae75efcb812f02a686c67ead8f3f0d71"
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
