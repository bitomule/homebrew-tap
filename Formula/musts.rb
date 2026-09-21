class Musts < Formula
  desc "Agent-first validation loop CLI."
  homepage "https://github.com/bitomule/musts"
  version "0.8.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bitomule/musts/releases/download/musts-v0.8.0/musts-aarch64-apple-darwin.tar.xz"
    sha256 "ce6f09b0a61a43e89d7160eb3b22a6cc463a7fc0e426132a047015f4b94abb9f"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/musts/releases/download/musts-v0.8.0/musts-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f7d1f888db97f989cc8cf9cfa23b958dfbdafe960bf0afce76b967a546fa026b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bitomule/musts/releases/download/musts-v0.8.0/musts-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1f2595afbd22c1f627da74c9b4babaec631a55a0bc266d95956451e6b70ac758"
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
