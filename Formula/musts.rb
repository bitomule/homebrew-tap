class Musts < Formula
  desc "Agent-first validation loop CLI."
  homepage "https://github.com/bitomule/musts"
  version "0.2.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bitomule/musts/releases/download/musts-v0.2.1/musts-aarch64-apple-darwin.tar.xz"
    sha256 "65fa948cdc877a29bb7cee45f34b29bdf5f572c7ed06ed7224edec7668789bbb"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/musts/releases/download/musts-v0.2.1/musts-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "65486e64a1e474a7b61dd3f57fdb6bfafbb2a33826c0ab13d0d601a1e85b0ff5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bitomule/musts/releases/download/musts-v0.2.1/musts-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "601640385a5465670dc67154df07e7e8e41676ef9c08fb954982b17936ec06e5"
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
      bin.install "musts"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "musts"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "musts"
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
