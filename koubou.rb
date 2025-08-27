class Koubou < Formula
  desc "🎯 Koubou (工房) - The artisan workshop for App Store screenshots"
  homepage "https://github.com/bitomule/koubou"
  url "https://github.com/bitomule/Koubou/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "012ee92e738a08b8ccebfa96adb51cb265a4d83ec9d356d5f88a4e01067d48f5"
  license "MIT"
  head "https://github.com/bitomule/koubou.git", branch: "main"

  depends_on "python@3.9" => [:build, :test]
  depends_on "python@3.10" => [:build, :test]
  depends_on "python@3.11" => [:build, :test] 
  depends_on "python@3.12" => [:build, :test]

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  resource "pillow" do
    url "https://files.pythonhosted.org/packages/cd/74/ad3d526f3bf7b6d3f408b73fde271ec69dfac8b81341a318ce825f2b3812/pillow-10.4.0.tar.gz"
    sha256 "166c1cd4d24309b30d61f79f4a9114b7b2313d19a60c22a6c94be89b14aeb00"
  end

  resource "pydantic" do
    url "https://files.pythonhosted.org/packages/a9/b7/d9e3f12af310e1120c21603644a1cd86f59060e040ec5c3a80b8f05fae30/pydantic-2.11.2.tar.gz"
    sha256 "c398adacf5340d78e5a7e3e35c9e3e0ba4de9aefc7f00b2c2e58e8ae0b1e7936"
  end

  resource "pydantic-core" do
    url "https://files.pythonhosted.org/packages/e2/aa/6b6a9b9f8537b872f552ddd46dd3da230367754b6f707b8e1e963f515ea3/pydantic_core-2.27.1.tar.gz"  
    sha256 "62a763352879b84aa31058fc931884055fd75089cccbd9d58bb6afd01141b235"
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/cb/ce/dca7b219718afd37a0068f4f2530a727c8b3ed8bc77c18aa3a9bb4b7001e/typer-0.15.1.tar.gz"
    sha256 "a0588c0a7fa68a1978a069818657778f86abe6ff5ea6abf472f940a08bfe4f0a"
  end

  resource "pyyaml" do  
    url "https://files.pythonhosted.org/packages/cd/e5/af35f7ea75cf72f2cd079c95ee16797de7cd71f29ea7c68ae5ce7be1eda0/PyYAML-6.0.1.tar.gz"
    sha256 "bfdf460b1736c775f2ba9f6a92bca30bc2095067b8a9d77876d1fad6cc3b4a43"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/b8/0a/2d324f8cb40f51218ba3ad3d6567a90fcafa6d3f9d5b2ebb9b9e823d9ea8/rich-13.9.4.tar.gz"
    sha256 "439594978a49a09530cff7ebc4b5c7103ef57baf48d5ea3184f21d9a2befa098"
  end

  def install
    # Install with pip in isolated mode
    system "python3", "-m", "pip", "install", "--no-deps", "--prefix=#{prefix}", "."
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