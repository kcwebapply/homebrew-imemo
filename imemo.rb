require "formula"

HOMEBREW_IMEMO_VERSION='0.0.1'

class Httr < Formula
  desc "save memo easily on terminal."
  url "https://github.com/kcwebapply/imemo/archive/1.2.0.tar.gz"
  homepage "https://github.com/kcwebapply/imemo"
  sha256 "fe443ab343e7f335dfa05b772512bc75c303812f43ba7795d7ed1b6a8ca15e70"

  depends_on "dep" => :build
  depends_on "go" => :build

  def install
    print buildpath
    ENV["GOPATH"] = buildpath
    cloud_nuke_path = buildpath/"src/github.com/kcwebapply/imemo/"
    cloud_nuke_path.install buildpath.children

    cd cloud_nuke_path do
      system "dep", "ensure", "-vendor-only"
      system "go", "build", "-ldflags", "-X main.VERSION=#{version}"
      bin.install "imemo"
    end
  end

  test do
    assert_match "memo saved!", shell_output("#{bin}/imemo save test ")
  end
end

