class Alondra < Formula
  desc "Private task and notification bridge for Claude"
  homepage "https://davidcollado.dev"
  version "0.1.6"

  depends_on macos: :sonoma

  # Signed bytes must survive Homebrew cleaning unchanged.
  skip_clean "bin/alondra", "bin/alondrad"

  on_arm do
    url "https://github.com/bitomule/homebrew-tap/releases/download/alondra-v#{version}/alondra-#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "151c4c2f08b535ea7e53f406825bd5b3697f98174c42de462d601f775db1cf84"
  end

  on_intel do
    url "https://github.com/bitomule/homebrew-tap/releases/download/alondra-v#{version}/alondra-#{version}-x86_64-apple-darwin.tar.gz"
    sha256 "441a0af324ad8d56a2fd43270ac315462171e448745417a44a6d7593e555065e"
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
