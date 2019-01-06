require "formula"

HOMEBREW_IMEMO_VERSION='0.0.1'

class Httr < Formula
  url "https://github.com/kcwebapp;y/imemo/releases/download/#{HOMEBREW_HTTR_VERSION}/imemo-release-amd64.tar.gz"
  homepage "https://github.com/kcwebapply/imemo"
  sha256 "86a5a760876555748fc49af26b4368ee93ef6a54c847cd3aa7246244425aa342"

  version HOMEBREW_IMEMO_VERSION
  head 'https://github.com/kcwebapply/imemo.git', :branch => 'master'

  def install
    bin.install 'imemo'
  end

end
