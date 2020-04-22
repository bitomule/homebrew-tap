class SwiftyPods < Formula
  desc "A tool to generate CocoaPods podfile's using Swift"
  homepage "https://github.com/bitomule/SwiftyPods"
  url "https://github.com/bitomule/SwiftyPods.git",
      :tag => "0.1.0"
  head "https://github.com/bitomule/SwiftyPods.git"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
