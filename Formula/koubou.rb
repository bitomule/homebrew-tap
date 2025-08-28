class Koubou < Formula
  include Language::Python::Virtualenv

  desc "🎯 Koubou (工房) - The artisan workshop for App Store screenshots"
  homepage "https://github.com/bitomule/koubou"
  url "https://files.pythonhosted.org/packages/1e/9f/b552eef12217ec6bc1dd04f3f463cab6a6a3d7bd9cc85b79d7cfb3f079c8/koubou-0.1.6.tar.gz"
  sha256 "ea72297dcf5251a87d07ef15d60784e5a4c1fa3ad56e792fc942726e64b00964"
  license "MIT"
  head "https://github.com/bitomule/koubou.git", branch: "main"

  depends_on "python@3.12"

  def install
    # Create virtualenv and ensure pip is available
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "venv", libexec
    
    # Install koubou and let pip handle dependencies automatically (uses binary wheels)
    system libexec/"bin/pip", "install", "--no-binary", "koubou", "."
    
    # Create wrapper script
    bin.install_symlink libexec/"bin/kou"
  end

  def caveats
    <<~EOS
      🎯 Koubou (工房) is ready! 

      Transform YAML into handcrafted App Store screenshots.
      Your professional workshop where every screenshot 
      is carefully crafted with artisan quality.

      Quick start:
        kou create-config my-screenshots.yaml    # Create sample config
        kou generate my-screenshots.yaml         # Generate screenshots  
        kou list-frames                          # List available device frames
        kou --help                               # Show all commands

      Features:
        🎨 100+ Device Frames: iPhone, iPad, Mac, Watch
        🌈 Professional Backgrounds: Linear, radial, conic gradients
        ✨ Rich Typography: Advanced text overlays with stroke
        📱 YAML Configuration: Elegant, declarative definitions
        🚀 Batch Processing: Generate multiple screenshots efficiently

      Documentation: https://github.com/bitomule/koubou
    EOS
  end

  test do
    system "#{bin}/kou", "--version"
    assert_match "🎯 Koubou v0.1.6", shell_output("#{bin}/kou --version")
    system "#{bin}/kou", "--help"

    # Create a minimal test configuration
    (testpath/"test.yaml").write <<~EOS
      project:
        name: "Test Project"
        output_dir: "./output"
      devices: ["iPhone 15 Pro Portrait"]
      screenshots:
        - name: "Test Screenshot"
          content:
            - type: "text"
              content: "Hello World"
              position: ["50%", "50%"]
    EOS

    # Test configuration validation (should not crash)
    system "#{bin}/kou", "create-config", "sample.yaml", "--name", "Test"
    assert_predicate testpath/"sample.yaml", :exist?
  end
end