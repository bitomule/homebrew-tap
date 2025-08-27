class Kamui < Formula
  desc "🎯 Advanced session manager for Claude Code with automatic status line integration"
  homepage "https://github.com/bitomule/kamui"
  url "https://github.com/bitomule/kamui/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "d440b371f379d1140e8a5d882d7e7d28255a5de868a5ce50071fb0a1f213f2bc"
  license "MIT"
  head "https://github.com/bitomule/kamui.git", branch: "main"

  depends_on "go" => :build

  def install
    # Build from source with version info
    ldflags = %W[
      -s -w
      -X main.version=0.0.1
      -X main.commit=97f13a12f71fffda645e5791572c8b4329ca1c45
      -X main.date=#{time.iso8601}
    ]
    
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/kam"
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
