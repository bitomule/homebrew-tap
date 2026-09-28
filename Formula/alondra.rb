class Alondra < Formula
  desc "Private task and notification bridge for Claude"
  homepage "https://davidcollado.dev"
  version "0.1.11"

  depends_on macos: :sonoma

  # Signed bytes must survive Homebrew cleaning unchanged.
  skip_clean "bin/alondra", "bin/alondrad"

  on_arm do
    url "https://github.com/bitomule/homebrew-tap/releases/download/alondra-v#{version}/alondra-#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "bb345506ff9128e4a810415010c2646e1b32f44df736f080a7f48535bba0a945"
  end

  on_intel do
    url "https://github.com/bitomule/homebrew-tap/releases/download/alondra-v#{version}/alondra-#{version}-x86_64-apple-darwin.tar.gz"
    sha256 "49763f41ce5546b719e566108c9f28cac61bc7b8ab87a27ff86050809d209adb"
  end

  def install
    bin.install "alondra", "alondrad"
    (libexec/"alondra").install ".claude-plugin", "plugin", "plugin-orchestrator"
  end

  def caveats
    <<~EOS
      Run `alondra setup` to sign in, install the Claude plugins, and start the daemon.
      Run it again after `brew upgrade alondra` to restart the daemon on the new version.
    EOS
  end

  test do
    assert_match "Alondra", shell_output("#{bin}/alondra --help")
  end
end
