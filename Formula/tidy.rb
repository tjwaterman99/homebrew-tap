class Tidy < Formula
  desc "Keeps your home directory free of stray files, nightly"
  homepage "https://github.com/tjwaterman99/tidy"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tjwaterman99/tidy/releases/download/v0.1.0/tidy-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "ef5e9c0937a0316a22a54ca928ab91edddffe925ae4a25dbf34bb7eb3fddb23d"
    end
    on_intel do
      url "https://github.com/tjwaterman99/tidy/releases/download/v0.1.0/tidy-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "9286ef586e07d876028ce717eb46f6e2545808a19dc1ca399bf3dac05de675b4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tjwaterman99/tidy/releases/download/v0.1.0/tidy-0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fb74d56e20b1c50eeffb458a55698c8d5d77a366b23fce2d61457828b8ed76a5"
    end
    on_intel do
      url "https://github.com/tjwaterman99/tidy/releases/download/v0.1.0/tidy-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ea8e42d7b8dd7390f9e1f54ba4261586df15559bda9aa4f61b4787883d1e8f1d"
    end
  end

  def install
    bin.install "tidy"
  end

  # One run a night at 03:00. launchd runs a missed time on wake from sleep,
  # not after the machine was off. run_at_load false: starting the service
  # does not run it straight away.
  service do
    run [opt_bin/"tidy", "run"]
    run_type :cron
    cron "0 3 * * *"
    run_at_load false
    log_path var/"log/tidy.log"
    error_log_path var/"log/tidy.log"
    environment_variables PATH: std_service_path_env
  end

  def caveats
    <<~EOS
      tidy starts in report mode: it logs what it would move and changes nothing.
        tidy init               # writes ~/.config/tidy/config.toml
        tidy run --dry-run      # preview
        brew services start tidy
      Set mode = "move" in the config when the reports look right.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tidy --version")
  end
end
