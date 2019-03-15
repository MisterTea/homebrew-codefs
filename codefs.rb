class RRequirement < Requirement
  fatal true

  satisfy(:build_env => false) { File.file?("/usr/local/lib/pkgconfig/osxfuse.pc") }

  def message; <<~EOS
    OSXFuse is required; install it via:
      brew cask install osxfuse
    EOS
  end
end

class Codefs < Formula
  desc "Remote Filesystem for software developement"
  homepage "https://github.com/MisterTea/CodeFS"
  url "https://github.com/MisterTea/CodeFS/archive/codefs-v0.0.1.tar.gz"
  head "https://github.com/MisterTea/CodeFS.git"
  version "0.0.1"
  sha256 "37b9bd33ed3edc88cedf2c4168246e23818ccd4e08731d0698d8d133dd3b1147"
  revision 1

  depends_on "cmake" => :build

  depends_on "protobuf"
  depends_on "zeromq"
  depends_on "gflags"
  depends_on "boost"
  depends_on "fswatch"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "-j4", "install"
  end

  test do
    system "#{bin}/codefs", "--help"
  end
end
