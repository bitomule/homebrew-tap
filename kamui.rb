class Kamui < Formula
  desc "🎯 Advanced session manager for Claude Code with automatic status line integration"
  homepage "https://github.com/bitomule/kamui"
  url "https://github.com/bitomule/kamui/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "ff4f87f0d7ef8b4e849b8b670db4c2ab953de064ce8c641db10daf9d07c5e953"
  license "MIT"
  head "https://github.com/bitomule/kamui.git", branch: "main"

  depends_on "go" => :build

  def install
    # Build from source with version info
    ldflags = %W[
      -s -w
      -X main.version=0.0.2
      -X main.commit=07fc9c238e51ac0c6ec4ed7cff7d1b51dfd1ca10
      -X main.date=#{time.iso8601}
    ]
    
    system "go", "build", "-ldflags", ldflags.join(" "), "-o", bin/"kam", "./cmd/kam"
  end

  def caveats
    <<~EOS
      🎯 Kamui is ready! 

      Quick start:
        kam MyProject          # Create/resume a session
        kam                   # Interactive session picker
        kam setup            # Configure Claude Code integration

      Requirements:
        • Claude Code CLI must be installed
        • Download from: https://claude.ai/code

      The status line will be configured automatically on first use.
    EOS
  end

  test do
    system "#{bin}/kam", "--version"
    system "#{bin}/kam", "--help"
  end
end
