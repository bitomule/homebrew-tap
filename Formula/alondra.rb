class Alondra < Formula
  desc "Task and notification bridge for Claude and Codex"
  homepage "https://github.com/bitomule/alondra"
  version "0.3.29"
  license "Elastic-2.0"

  depends_on macos: :tahoe
  depends_on arch: :arm64
  depends_on "tuicr"

  # Signed bytes must survive Homebrew cleaning unchanged.
  skip_clean "bin/alondra", "bin/alondrad", "bin/alondrad-launcher", "libexec/alondra/sdk/alondra-host", "libexec/alondra/codex/alondra-codex-host"

  url "https://github.com/bitomule/homebrew-tap/releases/download/alondra-v#{version}/alondra-#{version}-aarch64-apple-darwin.tar.gz"
  sha256 "a1cc811ba25ec7a1de1790dd5c6ea38f5dc24657f06761b4995c6a567d8e1cc9"

  def install
    bin.install "alondra", "alondrad", "alondrad-launcher"
    prefix.install "LICENSE.md", "THIRD_PARTY_NOTICES.md"
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
