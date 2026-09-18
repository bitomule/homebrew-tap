class Simpool < Formula
  desc "iOS simulator pool broker with flock-guarded slots"
  homepage "https://github.com/bitomule/simpool"
  version "0.19.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-arm64"
      sha256 "ba66ce0727bdb0f1529423506a0ac2862241f3255547d5e71f860ec55f1a6b16"
    else
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-amd64"
      sha256 "49e5aa913dc5ebf4c9c577719910a7cbee6796020f5bd7dfe9dd49fa8006e6c6"
    end
  end

  def install
    bin.install cached_download => "simpool"
    chmod 0755, bin/"simpool"
  end

  # Nothing runs reap on its own, and the pool's health depends on
  # it: with deliberately does not shut simulators down on exit, so
  # on a machine with no schedule the only cleanup that happens is
  # whatever someone types. Measured before this existed: seven pool
  # simulators still booted with no holder, four idle for 25 to 46
  # hours, 24 GB of swap against 18 GB of RAM, disk at 0.1 GB free.
  #
  # --scrub 120 empties a slot's generated caches, logs and
  # temporary files once it has been cold for two hours, keeping
  # the simulator itself. Measured at 1.3-1.9GB per slot. Safe to
  # schedule precisely because it destroys nothing a slot cannot
  # regenerate, which is what separates it from --purge.
  #
  # Shipped as a Homebrew service rather than a plist simpool writes
  # itself: installing something that starts on login is the user's
  # decision, made explicitly with "brew services start simpool",
  # never a side effect of installing a binary.
  service do
    run [opt_bin/"simpool", "reap", "--purge-orphan-runtimes", "--cold", "60", "--warm", "2", "--scrub", "120"]
    run_type :interval
    interval 1800
    log_path "/tmp/simpool-reap.log"
    error_log_path "/tmp/simpool-reap.log"
  end

  test do
    assert_match "simpool", shell_output("#{bin}/simpool status 2>&1", 0)
    # Not just that it runs: that the binary Homebrew installed
    # reports the version Homebrew thinks it installed. An
    # unstamped build says "dev", which would fail here rather
    # than shipping a copy that cannot identify itself.
    assert_equal "v#{version}", shell_output("#{bin}/simpool version --short").strip
  end
end
