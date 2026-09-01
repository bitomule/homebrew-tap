class Simpool < Formula
  desc "iOS simulator pool broker with flock-guarded slots"
  homepage "https://github.com/bitomule/simpool"
  version "0.15.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-arm64"
      sha256 "e958a84d21962d0aa9a6b46c9f852b3f831dc7ded42edadb3bd2ca80ebd2bf79"
    else
      url "https://github.com/bitomule/simpool/releases/download/v#{version}/simpool-darwin-amd64"
      sha256 "b6b03ed9215f50c63269d51cda78c999fa78d4f128b0a0c38c23205033a8aab5"
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
  # Shipped as a Homebrew service rather than a plist simpool writes
  # itself: installing something that starts on login is the user's
  # decision, made explicitly with "brew services start simpool",
  # never a side effect of installing a binary.
  service do
    run [opt_bin/"simpool", "reap", "--purge-orphan-runtimes", "--cold", "60", "--warm", "2"]
    run_type :interval
    interval 1800
    log_path "/tmp/simpool-reap.log"
    error_log_path "/tmp/simpool-reap.log"
  end

  test do
    assert_match "simpool", shell_output("#{bin}/simpool status 2>&1", 0)
  end
end
