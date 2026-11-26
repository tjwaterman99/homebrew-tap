class Weir < Formula
  desc "Keeps local, read-only mirrors of your repositories up to date"
  homepage "https://github.com/tjwaterman99/weir"
  version "0.2.0"

  on_macos do
    on_arm do
      url "https://github.com/tjwaterman99/weir/releases/download/v0.2.0/weir-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "70ed89a466b4bab9cc277bc40f389409ea93b62970f19ba7495c8a087b01f489"
    end
    on_intel do
      url "https://github.com/tjwaterman99/weir/releases/download/v0.2.0/weir-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "0759015cff4c105de19e05097a837d4e9179b636373e97bd825e49716aba15a3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tjwaterman99/weir/releases/download/v0.2.0/weir-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "97d1bbb3d58413e5cf6fbfc61f5ffeacdc616207803652e861547b2429b42bde"
    end
    on_intel do
      url "https://github.com/tjwaterman99/weir/releases/download/v0.2.0/weir-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5c491b16645facb5f9376194776433141db3c3469e5836980ad0440670e46915"
    end
  end

  def install
    bin.install "weir"
  end

  def caveats
    <<~EOS
      To keep your mirrors current in the background, run:
        weir service install
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/weir version")
  end
end
