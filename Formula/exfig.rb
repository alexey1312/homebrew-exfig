class Exfig < Formula
  desc "Export colors, typography, icons, and images from Figma to Xcode, Android, Flutter, and Web"
  homepage "https://github.com/alexey1312/ExFig"
  version "1.3.0"
  license "MIT"

  on_macos do
    url "https://github.com/alexey1312/ExFig/releases/download/v#{version}/exfig-macos.zip"
    sha256 "f29e3e4e21f8f843d14d2c230b668ba2c889fd237255e620e41239e7f49a7a2e"

    depends_on macos: :monterey
  end

  on_linux do
    url "https://github.com/alexey1312/ExFig/releases/download/v#{version}/exfig-linux-x64.tar.gz"
    sha256 "10e08a4f14174cd9cc2e467ebea667c7524ee9b141ae2e4b560f6f79d0e5522f"
  end

  def install
    # Binary and bundles must be co-located for Bundle.module to find templates
    libexec.install "ExFig" => "exfig"
    libexec.install Dir["exfig_*.bundle"]     # macOS resource bundles
    libexec.install Dir["exfig_*.resources"]  # Linux resource bundles

    # Symlink to bin for PATH access
    bin.install_symlink libexec/"exfig"
  end

  def caveats
    <<~EOS
      Set your Figma Personal Access Token:
        export FIGMA_PERSONAL_TOKEN=your_token_here

      Get your token from: https://www.figma.com/developers/api#access-tokens
    EOS
  end

  test do
    assert_match "exfig", shell_output("#{bin}/exfig --version")
  end
end
