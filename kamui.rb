class Kamui < Formula
  desc "🎯 Advanced session manager for Claude Code with automatic status line integration"
  homepage "https://github.com/bitomule/kamui"
  url "https://github.com/bitomule/kamui/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "368af6b7f729347eec7ef9f43f65a8b8db8779c8b5f4e8e9c837533699689187"
  license "MIT"
  head "https://github.com/bitomule/kamui.git", branch: "main"

  depends_on "go" => :build

  def install
    # Build from source with version info
    ldflags = %W[
      -s -w
      -X main.version=0.0.2
      -X main.commit=18bce43ad1c8fb1e66480f0dbe66bae3f014dbd3
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
