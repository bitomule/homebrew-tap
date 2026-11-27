class Alondra < Formula
  desc "Task and notification bridge for Claude, Codex and Antigravity"
  homepage "https://github.com/bitomule/alondra"
  version "0.3.71"
  license "Elastic-2.0"

  depends_on macos: :tahoe
  depends_on arch: :arm64

  # Signed bytes must survive Homebrew cleaning unchanged.
  skip_clean "bin/alondra", "bin/alondrad", "bin/alondrad-launcher", "bin/alondra-spec", "libexec/alondra/sdk/alondra-host", "libexec/alondra/codex/alondra-codex-host",
            "libexec/alondra/antigravity/alondra-antigravity-host"

  url "https://github.com/bitomule/homebrew-tap/releases/download/alondra-v#{version}/alondra-#{version}-aarch64-apple-darwin.tar.gz"
  sha256 "6c73cb3007d5904546012356afb7d39c3bf28715754a1ed5d05f6dc2df31eb33"

  def install
    bin.install "alondra", "alondrad", "alondrad-launcher", "alondra-spec"
    prefix.install "LICENSE.md", "THIRD_PARTY_NOTICES.md"
    (libexec/"alondra").install ".claude-plugin", "plugin", "plugin-orchestrator", "sdk", "codex", "antigravity"
  end

  def caveats
    <<~EOS
      Run `alondra` to set up this Mac and open Alondra.
    EOS
  end

  test do
    assert_match "Alondra", shell_output("#{bin}/alondra --help")
    assert_match "alondra-spec", shell_output("#{bin}/alondra-spec --help")
  end
end
