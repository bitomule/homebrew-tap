class Koubou < Formula
  include Language::Python::Virtualenv

  desc "🎯 Koubou (工房) - The artisan workshop for App Store screenshots"
  homepage "https://github.com/bitomule/koubou"
  url "https://files.pythonhosted.org/packages/31/ed/0e933b3bad5eea92c4eb741c237a391a688a4cf67e5c3959dde1b585dc1e/koubou-0.4.7.tar.gz"
  sha256 "cc0e3f0a136d9e8a638e86814b8e10c0889286863b78efb7eb3d8d61bcc22ddc"
  license "MIT"
  head "https://github.com/bitomule/koubou.git", branch: "main"

  depends_on "python@3.12"

  resource "annotated-types" do
    url "https://files.pythonhosted.org/packages/ee/67/531ea369ba64dcff5ec9c3402f9f51bf748cec26dde048a2f973a4eea7f5/annotated_types-0.7.0.tar.gz"
    sha256 "aff07c09a53a08bc8cfccb9c85b05f1aa9a2a6f23728d790723543408344ce89"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/60/6c/8ca2efa64cf75a977a0d7fac081354553ebe483345c734fb6b6515d96bbc/click-8.2.1.tar.gz"
    sha256 "27c491cc05d968d271d5a1db13e3b5a184636d9d930f148c50b038f0d0646202"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/5b/f5/4ec618ed16cc4f8fb3b701563655a69816155e79e24a17b651541804721d/markdown_it_py-4.0.0.tar.gz"
    sha256 "cb0a2b4aa34f932c007117b194e945bd74e0ec24133ceb5bac59009cda1cb9f3"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
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

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/b0/77/a5b8c569bf593b0140bde72ea885a803b82086995367bf2037de0159d924/pygments-2.19.2.tar.gz"
    sha256 "636cb2477cec7f8952536970bc533bc43743542f70392ae026374600add5b887"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/54/ed/79a089b6be93607fa5cdaedf301d7dfb23af5f25c398d5ead2525b063e17/pyyaml-6.0.2.tar.gz"
    sha256 "d584d9ec91ad65861cc08d42e834324ef890a082e591037abe114850ff7bbc3e"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/fe/75/af448d8e52bf1d8fa6a9d089ca6c07ff4453d86c65c145d0a300bb073b9b/rich-14.1.0.tar.gz"
    sha256 "e497a48b844b0320d45007cdebfeaeed8db2a4f4bcf49f15e455cfc4af11eaa8"
  end

  resource "shellingham" do
    url "https://files.pythonhosted.org/packages/58/15/8b3609fd3830ef7b27b655beb4b4e9c62313a4e8da8c676e142cc210d58e/shellingham-1.5.4.tar.gz"
    sha256 "8dbca0739d487e5bd35ab3ca4b36e11c4078f3a234bfce294b0a0291363404de"
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/43/78/d90f616bf5f88f8710ad067c1f8705bf7618059836ca084e5bb2a0855d75/typer-0.16.1.tar.gz"
    sha256 "d358c65a464a7a90f338e3bb7ff0c74ac081449e53884b12ba658cbd72990614"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/72/94/1a15dd82efb362ac84269196e94cf00f187f7ed21c242792a923cdb1c61f/typing_extensions-4.15.0.tar.gz"
    sha256 "0cea48d173cc12fa28ecabc3b837ea3cf6f38c6d1136f85cbaaf598984861466"
  end

  resource "typing-inspection" do
    url "https://files.pythonhosted.org/packages/f8/b1/0c11f5058406b3af7609f121aaa6b609744687f1d158b3c3a5bf4cc94238/typing_inspection-0.4.1.tar.gz"
    sha256 "6ae134cc0203c33377d43188d4064e9b357dba58cff3185f22924610e70a9d28"
  end

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
    assert_match "🎯 Koubou v0.4.6", shell_output("#{bin}/kou --version")
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