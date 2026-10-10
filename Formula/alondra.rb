class Alondra < Formula
  desc "Private task and notification bridge for Claude"
  homepage "https://davidcollado.dev"
  version "0.2.63"

  depends_on macos: :sonoma
  depends_on arch: :arm64
  depends_on "tmux"
  depends_on "tuicr"

  # Signed bytes must survive Homebrew cleaning unchanged.
  skip_clean "bin/alondra", "bin/alondrad"

  url "https://github.com/bitomule/homebrew-tap/releases/download/alondra-v#{version}/alondra-#{version}-aarch64-apple-darwin.tar.gz"
  sha256 "b65d7afeb84912210fa6458827582df6daccdaaac7571dae5a2df79152ea7de4"

  def install
    bin.install "alondra", "alondrad"
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
