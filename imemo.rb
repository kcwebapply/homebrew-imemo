require "formula"

HOMEBREW_IMEMO_VERSION='0.0.1'

class Imemo < Formula
  desc "Save memo easily on terminal"
  homepage "https://github.com/kcwebapply/imemo"
  url "https://github.com/kcwebapply/imemo/archive/1.0.1.tar.gz"
  sha256 "3fba4ce91b8e2c46bcd499846862984feea17a4d23a30c08376fa66389302e33"

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

