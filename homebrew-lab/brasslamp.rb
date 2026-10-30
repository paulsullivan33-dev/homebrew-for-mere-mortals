class Brasslamp < Formula
  desc "Tiny invented program that prints one line about a brass lamp"
  homepage "https://example.invalid/brasslamp"
  url "file:///home/hatch/workspace/homebrew-labwork/fixtures/brasslamp-1.0.0.tar.gz"
  sha256 "f0f129fe7c59204aa6a5fe575aaa76fbe5e92ada2bc8acfba547ec616afa0326"
  license "MIT"

  def install
    bin.install "brasslamp"
  end

  test do
    assert_match "The brass lamp is lit.", shell_output("#{bin}/brasslamp")
    assert_match "The brass lamp is lit for Ada.", shell_output("#{bin}/brasslamp Ada")
  end
end
