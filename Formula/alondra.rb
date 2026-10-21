class Alondra < Formula
  desc "Private task and notification bridge for Claude"
  homepage "https://davidcollado.dev"
  version "0.3.1"

  depends_on macos: :sonoma
  depends_on arch: :arm64
  depends_on "tuicr"

  # Signed bytes must survive Homebrew cleaning unchanged.
  skip_clean "bin/alondra", "bin/alondrad", "bin/alondrad-launcher", "libexec/alondra/sdk/alondra-host"

  url "https://github.com/bitomule/homebrew-tap/releases/download/alondra-v#{version}/alondra-#{version}-aarch64-apple-darwin.tar.gz"
  sha256 "3c108480b6035d17fdf71f6a08430e1ec07ff292a104813d01f44574342b6474"

  def install
    bin.install "alondra", "alondrad", "alondrad-launcher"
    (libexec/"alondra").install ".claude-plugin", "plugin", "plugin-orchestrator", "sdk"
  end

  def caveats
    <<~EOS
      Run `alondra` to set up this Mac and open Alondra.
    EOS
  end

  test do
    assert_match "Alondra", shell_output("#{bin}/alondra --help")
  end
end
