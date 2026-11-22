class Musts < Formula
  desc "Agent-first validation loop CLI."
  homepage "https://github.com/bitomule/musts"
  version "0.10.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bitomule/musts/releases/download/musts-v0.10.1/musts-aarch64-apple-darwin.tar.xz"
    sha256 "0b465a5e8742ea0be1938bac5c745fa5cad1b5a23c7170e1aee2b1ea0b54e31d"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/musts/releases/download/musts-v0.10.1/musts-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e1494dbae4517194f848767ed7376117a4f786c93b1db3496970c2f81317906b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bitomule/musts/releases/download/musts-v0.10.1/musts-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f0407f69edb8095885e70ab2ffeeed90ea83ed013ffe41ece178c67acf232bdc"
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
