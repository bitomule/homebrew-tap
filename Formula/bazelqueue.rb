class Bazelqueue < Formula
  desc "Queue Bazel invocations until machine capacity is available"
  homepage "https://github.com/bitomule/bazelqueue"
  url "https://github.com/bitomule/bazelqueue/releases/download/v0.1.7/bazelqueue-aarch64-apple-darwin.tar.xz"
  version "0.1.7"
  sha256 "af1c74a5becb2562a5ca32b68582133ed8a397d869f98087c11704c15b9b59fa"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on arch: :arm64
  depends_on macos: :ventura
  depends_on "bazelisk"

  def install
    bin.install "bazelqueue"
    %w[bazel bazelisk].each do |name|
      (libexec/"shims").install_symlink bin/"bazelqueue" => name
    end
  end

  def caveats
    <<~EOS
      Activate per-user Bazel interception with:
        bazelqueue setup

      Existing user shims require an explicit reversible replacement:
        bazelqueue setup --preview --replace --migrate
        bazelqueue setup --replace --migrate

      After an upgrade, run bazelqueue setup to refresh the owned executable.
      Before removing the formula, run bazelqueue uninstall to restore user shims.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bazelqueue --version")
    assert_predicate libexec/"shims/bazel", :symlink?
    assert_predicate libexec/"shims/bazelisk", :symlink?
  end
end
