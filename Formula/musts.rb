class Musts < Formula
  desc "Agent-first validation loop CLI."
  homepage "https://github.com/bitomule/musts"
  version "0.7.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bitomule/musts/releases/download/musts-v0.7.0/musts-aarch64-apple-darwin.tar.xz"
    sha256 "95c6bed777e4e98e5af10d540583074d5e5cf69a9167cb64961527fd9386a052"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/musts/releases/download/musts-v0.7.0/musts-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c963ef5e748256b97c4ae560335ca12f0c863367c2053957e087d66b889211d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bitomule/musts/releases/download/musts-v0.7.0/musts-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ae19bc6add960908b3334391bb7b1148bd74b0a1c196e7a1889b8a89d8aa02c6"
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
