class MustsJev < Formula
  desc "The `uses: jev` capability for musts: ask a typed yes/no question about one file and branch on the answer."
  homepage "https://github.com/bitomule/musts"
  version "0.1.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bitomule/musts/releases/download/musts-jev-v0.1.0/musts-jev-aarch64-apple-darwin.tar.xz"
    sha256 "fb0466c0746f5f8d6f86cdbd104ba4a6b4023297915ad043233247fdfd0a80d2"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/musts/releases/download/musts-jev-v0.1.0/musts-jev-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5658b2c2c3edb8568d50ad6531fab54c0dd63d6094f4147513d4641c0d431880"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bitomule/musts/releases/download/musts-jev-v0.1.0/musts-jev-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a56c88593bcd6dd36fb00b6c078c1033ab3d42b93b210ff1ed64e95cfa96f6a5"
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
      bin.install "musts-jev"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "musts-jev"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "musts-jev"
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
