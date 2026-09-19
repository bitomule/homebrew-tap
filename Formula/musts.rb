class Musts < Formula
  desc "Agent-first validation loop CLI."
  homepage "https://github.com/bitomule/musts"
  version "0.5.3"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bitomule/musts/releases/download/musts-v0.5.3/musts-aarch64-apple-darwin.tar.xz"
    sha256 "976872759c439ad4b9995f45b87e75e1ed2d677206128445b3d13a240c4f43af"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/musts/releases/download/musts-v0.5.3/musts-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1ef5dbd59cfc9f4c1d0fb577650481c2010a82d70a40d32cf84ba1cd536e6e42"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bitomule/musts/releases/download/musts-v0.5.3/musts-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c53707a1b6869c50bb4254fdcb0bd5eccb55611fd2689b1de5236f3e8e71202f"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "musts", "musts-jev"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "musts", "musts-jev"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "musts", "musts-jev"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
