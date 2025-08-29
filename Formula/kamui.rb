class Kamui < Formula
  desc "🎯 Advanced session manager for Claude Code with automatic status line integration"
  homepage "https://github.com/bitomule/kamui"
  url "https://github.com/bitomule/Kamui/archive/refs/tags/v0.0.7.tar.gz"
  sha256 "25c2c9f40b1410747fdbf43611da2c4b748cdccdcf51271a32e18218ccfd37a8"
  license "MIT"
  head "https://github.com/bitomule/kamui.git", branch: "main"

  depends_on "go" => :build

  def install
    # Build from source with version info
    ldflags = %W[
      -s -w
      -X main.version=0.0.2
      -X main.commit=21583d760e7b932d13557306589cf35404e6ff91
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
