class Alondra < Formula
  desc "Private task and notification bridge for Claude"
  homepage "https://davidcollado.dev"
  version "0.1.14"

  depends_on macos: :sonoma

  # Signed bytes must survive Homebrew cleaning unchanged.
  skip_clean "bin/alondra", "bin/alondrad"

  on_arm do
    url "https://github.com/bitomule/homebrew-tap/releases/download/alondra-v#{version}/alondra-#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "07645bced0b6994d0f652d39bdad8e2cd298766f73b9b6911e827fe858316cf2"
  end

  on_intel do
    url "https://github.com/bitomule/homebrew-tap/releases/download/alondra-v#{version}/alondra-#{version}-x86_64-apple-darwin.tar.gz"
    sha256 "e9807fe66f7af00d6d7214de51c859dce6c0b1a5d0579c2cfa0c513280dc548a"
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
