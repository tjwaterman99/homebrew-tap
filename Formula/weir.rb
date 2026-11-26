class Weir < Formula
  desc "Keeps local, read-only mirrors of your repositories up to date"
  homepage "https://github.com/tjwaterman99/weir"
  version "0.2.1"

  on_macos do
    on_arm do
      url "https://github.com/tjwaterman99/weir/releases/download/v0.2.1/weir-0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "a0d0d2b491a277a5805aa81d2ca059857aa04869b951c4fb3d189584fbb6a9fc"
    end
    on_intel do
      url "https://github.com/tjwaterman99/weir/releases/download/v0.2.1/weir-0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "61ae791920a133d42185be9aed48d7a63d4b513970c1dcd10a5fcb14026f540c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tjwaterman99/weir/releases/download/v0.2.1/weir-0.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "87aab3d307af18581c6a37b4388ab1dc12dad7fa54f1e1eb4b9c9c645c38b63e"
    end
    on_intel do
      url "https://github.com/tjwaterman99/weir/releases/download/v0.2.1/weir-0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "43ad5f685ecf888d8e7dd4e5b9894c78152238543f41b33044952158c6ad09a8"
    end
  end

  def install
    bin.install "weir"
  end

  service do
    run [opt_bin/"weir", "daemon"]
    keep_alive true
    process_type :background
    log_path var/"log/weir.log"
    error_log_path var/"log/weir.log"
    environment_variables PATH: std_service_path_env
  end

  def caveats
    <<~EOS
      Set up an account and say what to mirror:
        weir auth login github.com
        weir track github.com/<owner>
      Then keep the mirrors current in the background:
        brew services start weir
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/weir version")
  end
end
