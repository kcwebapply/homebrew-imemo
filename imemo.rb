require "formula"

HOMEBREW_IMEMO_VERSION='1.0.2'

class Imemo < Formula
  desc "Save memo easily on terminal"
  homepage "https://github.com/kcwebapply/imemo"
  url "https://github.com/kcwebapply/imemo/archive/1.0.2.tar.gz"
  sha256 "dfa0deb8209efeab529a6e5f271445c14ded5d3033f12ad6e0a071ed0af7835d"

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

