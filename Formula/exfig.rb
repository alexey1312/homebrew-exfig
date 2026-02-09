class Exfig < Formula
  desc "Export colors, typography, icons, and images from Figma to Xcode, Android, Flutter, and Web"
  homepage "https://github.com/alexey1312/ExFig"
  version "2.0.0"
  license "MIT"

  on_macos do
    url "https://github.com/alexey1312/ExFig/releases/download/v#{version}/exfig-macos.zip"
    sha256 "ae1734e88b164bcfbf91470e34f5134c26440ba518f078efa535400cdfd31a58"

    depends_on macos: :monterey
  end

  on_linux do
    url "https://github.com/alexey1312/ExFig/releases/download/v#{version}/exfig-linux-x64.tar.gz"
    sha256 "34bdc69f88d6b480552c25043ab65ad762eab9a9bf3dc4f2c3fd4bd4aec07fd8"
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
