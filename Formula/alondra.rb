class Alondra < Formula
  desc "Task and notification bridge for Claude and Codex"
  homepage "https://davidcollado.dev"
  version "0.3.12"

  depends_on macos: :tahoe
  depends_on arch: :arm64
  depends_on "tuicr"

  # Signed bytes must survive Homebrew cleaning unchanged.
  skip_clean "bin/alondra", "bin/alondrad", "bin/alondrad-launcher", "libexec/alondra/sdk/alondra-host", "libexec/alondra/codex/alondra-codex-host"

  url "https://github.com/bitomule/homebrew-tap/releases/download/alondra-v#{version}/alondra-#{version}-aarch64-apple-darwin.tar.gz"
  sha256 "407ead11aa6081e7547044960acc7e834780c40cbb8375d94d5967e6d1be4470"

  def install
    bin.install "alondra", "alondrad", "alondrad-launcher"
    (libexec/"alondra").install ".claude-plugin", "plugin", "plugin-orchestrator", "sdk", "codex"
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
