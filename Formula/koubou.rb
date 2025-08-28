class Koubou < Formula
  include Language::Python::Virtualenv

  desc "🎯 Koubou (工房) - The artisan workshop for App Store screenshots"
  homepage "https://github.com/bitomule/koubou"
  url "https://files.pythonhosted.org/packages/1e/9f/b552eef12217ec6bc1dd04f3f463cab6a6a3d7bd9cc85b79d7cfb3f079c8/koubou-0.1.6.tar.gz"
  sha256 "ea72297dcf5251a87d07ef15d60784e5a4c1fa3ad56e792fc942726e64b00964"
  license "MIT"
  head "https://github.com/bitomule/koubou.git", branch: "main"

  depends_on "python@3.12"

  resource "click" do
    url "https://files.pythonhosted.org/packages/60/6c/8ca2efa64cf75a977a0d7fac081354553ebe483345c734fb6b6515d96bbc/click-8.2.1.tar.gz"
    sha256 "27c491cc05d968d271d5a1db13e3b5a184636d9d930f148c50b038f0d0646202"
  end

  resource "pillow" do
    url "https://files.pythonhosted.org/packages/f3/0d/d0d6dea55cd152ce3d6767bb38a8fc10e33796ba4ba210cbab9354b6d238/pillow-11.3.0.tar.gz"
    sha256 "3828ee7586cd0b2091b6209e5ad53e20d0649bbe87164a459d0676e035e8f523"
  end

  resource "pydantic" do
    url "https://files.pythonhosted.org/packages/00/dd/4325abf92c39ba8623b5af936ddb36ffcfe0beae70405d456ab1fb2f5b8c/pydantic-2.11.7.tar.gz"
    sha256 "d989c3c6cb79469287b1569f7447a17848c998458d49ebe294e975b9baf0f0db"
  end

  resource "pydantic-core" do
    url "https://files.pythonhosted.org/packages/ad/88/5f2260bdfae97aabf98f1778d43f69574390ad787afb646292a638c923d4/pydantic_core-2.33.2.tar.gz"
    sha256 "7cb8bc3605c29176e1b105350d2e6474142d7c1bd1d9327c4a9bdb46bf827acc"
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/43/78/d90f616bf5f88f8710ad067c1f8705bf7618059836ca084e5bb2a0855d75/typer-0.16.1.tar.gz"
    sha256 "d358c65a464a7a90f338e3bb7ff0c74ac081449e53884b12ba658cbd72990614"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/54/ed/79a089b6be93607fa5cdaedf301d7dfb23af5f25c398d5ead2525b063e17/pyyaml-6.0.2.tar.gz"
    sha256 "d584d9ec91ad65861cc08d42e834324ef890a082e591037abe114850ff7bbc3e"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/fe/75/af448d8e52bf1d8fa6a9d089ca6c07ff4453d86c65c145d0a300bb073b9b/rich-14.1.0.tar.gz"
    sha256 "e497a48b844b0320d45007cdebfeaeed8db2a4f4bcf49f15e455cfc4af11eaa8"
  end

  # Build dependency for setuptools_scm
  resource "setuptools-scm" do
    url "https://files.pythonhosted.org/packages/8f/8d/ffdcace33d0480d591057a30285b7c33f8dc431fed3fff7dbadf5f9f128f/setuptools_scm-9.2.0.tar.gz"
    sha256 "6662c9b9497b6c9bf13bead9d7a9084756f68238302c5ed089fb4dbd29d102d7"
  end

  def install
    # Create virtualenv and ensure pip is available
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "venv", libexec
    
    # Install all resource dependencies first  
    resources.each do |r|
      r.stage do
        system libexec/"bin/pip", "install", "--no-deps", "--no-binary", ":all:", "."
      end
    end
    
    # Install koubou itself
    system libexec/"bin/pip", "install", "--no-deps", "--no-binary", ":all:", "."
    
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