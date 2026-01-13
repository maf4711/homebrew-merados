class MeradosHealthchecker < Formula
  desc "Trading Portfolio Healthcheck Tool - 100% Lokal"
  homepage "https://github.com/maf4711/merados-healthchecker"
  url "https://github.com/maf4711/merados-healthchecker/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "e399796c3ddabe3589ecd9e30b86555988dd100f1a01dc5b5fbc250a541f3813"
  license "MIT"

  depends_on "python@3.12"

  def install
    libexec.install "kaizen_autopilot.py"
    libexec.install "merados_healthchecker" if File.directory?("merados_healthchecker")

    (bin/"merados-healthcheck").write <<~EOS
      #!/bin/bash
      exec "#{Formula["python@3.12"].opt_bin}/python3.12" "#{libexec}/kaizen_autopilot.py" "$@"
    EOS
  end

  def caveats
    <<~EOS
      Verwendung:
        merados-healthcheck                  # Standard-Analyse
        merados-healthcheck --selfheal       # Selfhealing mit Bestätigung
        merados-healthcheck --user 13997     # Nur User 13997
        merados-healthcheck --json           # JSON Output
        merados-healthcheck --help           # Alle Optionen
    EOS
  end

  test do
    assert_match "meradOS-Healthchecker v2.0", shell_output("#{bin}/merados-healthcheck --version")
  end
end
