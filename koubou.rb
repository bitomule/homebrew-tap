class Koubou < Formula
  desc "🎯 Koubou (工房) - The artisan workshop for App Store screenshots"
  homepage "https://github.com/bitomule/koubou"
  url "https://github.com/bitomule/Koubou/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "2883098c8bc62c39bb5d67239f0df296670489b5d3838d78e97f712162edf2c4"
  license "MIT"
  head "https://github.com/bitomule/koubou.git", branch: "main"

  depends_on "python@3.12"

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  resource "pillow" do
    url "https://files.pythonhosted.org/packages/cd/74/ad3d526f3bf7b6d3f408b73fde271ec69dfac8b81341a318ce825f2b3812/pillow-10.4.0.tar.gz"
    sha256 "166c1cd4d24309b30d61f79f4a9114b7b2313d7450912277855ff5dfd7cd4a06"
  end

  resource "pydantic" do
    url "https://files.pythonhosted.org/packages/b0/41/832125a41fe098b58d1fdd04ae819b4dc6b34d6b09ed78304fd93d4bc051/pydantic-2.11.2.tar.gz"
    sha256 "2138628e050bd7a1e70b91d4bf4a91167f4ad76fdb83209b107c8d84b854917e"
  end

  resource "pydantic-core" do
    url "https://files.pythonhosted.org/packages/17/19/ed6a078a5287aea7922de6841ef4c06157931622c89c2a47940837b5eecd/pydantic_core-2.33.1.tar.gz"
    sha256 "bcc9c6fdb0ced789245b02b7d6603e17d1563064ddcfc36f046b61c0c05dd9df"
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/cb/ce/dca7b219718afd37a0068f4f2530a727c2b74a8b6e8e0c0080a4c0de4fcd/typer-0.15.1.tar.gz"
    sha256 "a0588c0a7fa68a1978a069818657778f86abe6ff5ea6abf472f940a08bfe4f0a"
  end

  resource "pyyaml" do  
    url "https://files.pythonhosted.org/packages/cd/e5/af35f7ea75cf72f2cd079c95ee16797de7cd71f29ea7c68ae5ce7be1eda0/PyYAML-6.0.1.tar.gz"
    sha256 "bfdf460b1736c775f2ba9f6a92bca30bc2095067b8a9d77876d1fad6cc3b4a43"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/ab/3a/0316b28d0761c6734d6bc14e770d85506c986c85ffb239e688eeaab2c2bc/rich-13.9.4.tar.gz"
    sha256 "439594978a49a09530cff7ebc4b5c7103ef57baf48d5ea3184f21d9a2befa098"
  end

  def install
    # Use virtualenv to avoid system conflicts
    venv = libexec/"venv"
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "venv", venv
    
    # Install dependencies into virtualenv from PyPI (allows binary wheels)
    system venv/"bin/pip", "install", "-v", 
           "click==8.1.7",
           "pillow==10.4.0", 
           "pydantic==2.11.2",
           "pydantic-core==2.33.1",
           "typer==0.15.1",
           "PyYAML==6.0.1", 
           "rich==13.9.4"
    
    # Install koubou itself
    system venv/"bin/pip", "install", "-v", "--no-deps", "."
    
    # Create wrapper script
    (bin/"kou").write_env_script venv/"bin/kou", PATH: "#{venv}/bin:$PATH"
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