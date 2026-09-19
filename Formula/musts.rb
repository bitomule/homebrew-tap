class Musts < Formula
  desc "Agent-first validation loop CLI."
  homepage "https://github.com/bitomule/musts"
  version "0.5.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bitomule/musts/releases/download/musts-v0.5.1/musts-aarch64-apple-darwin.tar.xz"
    sha256 "57b117844cd8c0e22dd0a0f43bbf5f358ee86a467a8d982962f74cad4b97a8ac"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/musts/releases/download/musts-v0.5.1/musts-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bdc852ab7ed9cdb449063d4a4b63e0884c3b9f625234c7e1743c0fd4acdcfaa9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bitomule/musts/releases/download/musts-v0.5.1/musts-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "747469eacd661777071d3fff342dc8c3b107162f025946a8d18ea3a0827e8050"
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
