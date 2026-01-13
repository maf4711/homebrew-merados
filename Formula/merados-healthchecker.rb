class MeradosHealthchecker < Formula
  desc "Trading Portfolio Healthcheck Tool - 100% Lokal"
  homepage "https://github.com/maf4711/merados-healthchecker"
  url "https://github.com/maf4711/merados-healthchecker/archive/refs/heads/elated-blackwell.tar.gz"
  version "2.0.0"
  sha256 "f134cb1da3acea96d21d6720e82ef58d9b08c2374b5ce9412d79bd350f8a6903"
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
        merados-healthcheck --user 13997     # Nur User 13997
        merados-healthcheck --json           # JSON Output
        merados-healthcheck --help           # Alle Optionen

      Daten-Verzeichnis setzen:
        merados-healthcheck --data-dir /pfad/zu/csv

      Benötigte CSV-Dateien:
        - users_rows (1).csv
        - portfolios_rows (6).csv
        - transactions_rows (4).csv
    EOS
  end

  test do
    assert_match "meradOS-Healthchecker v2.0", shell_output("#{bin}/merados-healthcheck --version")
  end
end
