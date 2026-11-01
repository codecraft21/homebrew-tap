class KeystoreTui < Formula
  desc "Read-only terminal UI for inspecting JKS, JCEKS, and PKCS12 keystores, certificates, and certificate requests"
  homepage "https://github.com/codecraft21/keystore-tui"
  version "1.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.0.3/keystore-tui-aarch64-apple-darwin.tar.xz"
      sha256 "a2fe4b2057947331f97904117c32a256f90b3adf1e73e9d41a8edb9db53e938c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.0.3/keystore-tui-x86_64-apple-darwin.tar.xz"
      sha256 "4b65f0557c547f7fc57cb9145fb7c842e7d2020ca10212efc27034828a179d37"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.0.3/keystore-tui-aarch64-unknown-linux-musl.tar.xz"
      sha256 "10a38edc22e2ee681abeef710bed1186021a0b39452d0a13b6ee7584db67ee8f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.0.3/keystore-tui-x86_64-unknown-linux-musl.tar.xz"
      sha256 "cf4e99e00dedc37a6ff3b4ff4fa95bbb1f599f2e2a276d8486565f5bb83f4d59"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "keystore-tui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "keystore-tui"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "keystore-tui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "keystore-tui"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
