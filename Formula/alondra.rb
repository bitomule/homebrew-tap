class Alondra < Formula
  desc "Private task and notification bridge for Claude"
  homepage "https://davidcollado.dev"
  version "0.1.7"

  depends_on macos: :sonoma

  # Signed bytes must survive Homebrew cleaning unchanged.
  skip_clean "bin/alondra", "bin/alondrad"

  on_arm do
    url "https://github.com/bitomule/homebrew-tap/releases/download/alondra-v#{version}/alondra-#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "097e2e2571eecb8de3415b9293b14190a68e44d5b1b477e63a37daabaf4dec14"
  end

  on_intel do
    url "https://github.com/bitomule/homebrew-tap/releases/download/alondra-v#{version}/alondra-#{version}-x86_64-apple-darwin.tar.gz"
    sha256 "6781978b837092edbf03c7f4808423a37ef481f931d7a73b0e729605842ae559"
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
