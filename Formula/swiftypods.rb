class Swiftypods < Formula
  desc "SwiftyPods is a command-line tool that allows you to generate your CocoaPods podfile using Swift"
  homepage "https://github.com/bitomule/SwiftyPods"
  url "https://github.com/bitomule/SwiftyPods.git",
      :tag => "0.2.0"
  head "https://github.com/bitomule/SwiftyPods.git"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
