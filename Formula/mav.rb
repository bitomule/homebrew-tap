# Canonical release template. Render with packaging/homebrew/render.py.
class Mav < Formula
  desc "Mobile Agent Verifier for iOS apps"
  homepage "https://github.com/bitomule/mav"
  version "0.34.1"
  depends_on "cameroncooke/axe/axe"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-arm64"
      sha256 "fe397be14621f2ebd11f248f7b2eecc59ea6460705f3413dfbe62930cdde155f"
    else
      url "https://github.com/bitomule/mav/releases/download/v#{version}/mav-darwin-amd64"
      sha256 "32a4e07c5f6730ba104c5668d3d3a6e358a08fd842b48bf32c023b8a1fa6b36a"
    end
  end

  def install
    bin.install cached_download => "mav"
    chmod 0755, bin/"mav"
  end

  test do
    assert_match "Mobile Agent Verifier", shell_output("#{bin}/mav")
    assert_match "version=#{version}", shell_output("#{bin}/mav --version")
  end
end
