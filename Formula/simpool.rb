class Simpool < Formula
  desc "iOS simulator pool broker with flock-guarded slots"
  homepage "https://github.com/bitomule/simpool"
  version "0.8.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-arm64"
      sha256 "507bf0c51d5f6fbed9ebc92bb30b154cac11d9b86275491ec40c3088e2931e7c"
    else
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-amd64"
      sha256 "8a8d9ca47f6fad05c6cd4b7cbfd143e9d122b2748775f651473dc9aad8cb1091"
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
