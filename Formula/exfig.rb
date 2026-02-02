class Exfig < Formula
  desc "Export colors, typography, icons, and images from Figma to Xcode, Android, Flutter, and Web"
  homepage "https://github.com/alexey1312/ExFig"
  version "1.2.30"
  license "MIT"

  on_macos do
    url "https://github.com/alexey1312/ExFig/releases/download/v#{version}/exfig-macos.zip"
    sha256 "cfb7adb28d1444e98e005280d6ff230d69e863cb1d4450db7c651c3101e02f9e"

    depends_on macos: :monterey
  end

  on_linux do
    url "https://github.com/alexey1312/ExFig/releases/download/v#{version}/exfig-linux-x64.tar.gz"
    sha256 "b622496fb96c2ca9a16e73ece51f8a1381c5a24bf1621753d32dd4c196a15177"
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
