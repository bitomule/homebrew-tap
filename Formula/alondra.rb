class Alondra < Formula
  desc "Private task and notification bridge for Claude"
  homepage "https://davidcollado.dev"
  version "0.2.89"

  depends_on macos: :sonoma
  depends_on arch: :arm64
  depends_on "tmux"
  depends_on "tuicr"

  # Signed bytes must survive Homebrew cleaning unchanged.
  skip_clean "bin/alondra", "bin/alondrad", "bin/alondrad-launcher"

  url "https://github.com/bitomule/homebrew-tap/releases/download/alondra-v#{version}/alondra-#{version}-aarch64-apple-darwin.tar.gz"
  sha256 "12b22987ed3778a631d0d21b5add93ead0319f13cf92f6bf6328530e6b83dfda"

  def install
    bin.install "alondra", "alondrad", "alondrad-launcher"
    (libexec/"alondra").install ".claude-plugin", "plugin", "plugin-orchestrator"
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
