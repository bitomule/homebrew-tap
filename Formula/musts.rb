class Musts < Formula
  desc "Agent-first validation loop CLI."
  homepage "https://github.com/bitomule/musts"
  version "0.3.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bitomule/musts/releases/download/musts-v0.3.0/musts-aarch64-apple-darwin.tar.xz"
    sha256 "af196b046b861b5deea5758c0914c7fe523a45cc0e36f48f70457bec48b5d5f7"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/musts/releases/download/musts-v0.3.0/musts-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8a87bff39d8b6a77acfcc6e4ee1397798b9214c34c502935571de48c8904391d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bitomule/musts/releases/download/musts-v0.3.0/musts-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f39d9ac78da40595e2ce8985432fd74c942cb2b50a05bdca95d9076277bcbee6"
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
