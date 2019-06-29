require "formula"

HOMEBREW_IMEMO_VERSION='1.1.0'

class Imemo < Formula
  desc "Save memo easily on terminal"
  homepage "https://github.com/kcwebapply/imemo"
  url "https://github.com/kcwebapply/imemo/archive/1.1.0.tar.gz"
  sha256 "7d0b442e67b821a519ddaf948e00943a6f461fa4576b6a1b19165f89cd82a9a7"

  depends_on "dep" => :build
  depends_on "go" => :build

  def install
    print buildpath
    ENV["GOPATH"] = buildpath
    imemo_path = buildpath/"src/github.com/kcwebapply/imemo/"
    imemo_path.install buildpath.children

    cd imemo_path do
      system "dep", "ensure", "-vendor-only"
      system "go", "build"
      bin.install "imemo"
    end
  end

  test do
    assert_match "memo saved!", shell_output("#{bin}/imemo save \"learning math\" ")
    assert_match "1 learning math", shell_output("#{bin}/imemo all ")
    assert_match "", shell_output("#{bin}/imemo delete 1")
    assert_match "", shell_output("#{bin}/imemo all ")
  end
end

