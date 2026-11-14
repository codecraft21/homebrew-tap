class KeystoreTui < Formula
  desc "Terminal UI for inspecting JKS, JCEKS, and PKCS12 keystores, certificates, and certificate requests"
  homepage "https://github.com/codecraft21/keystore-tui"
  version "1.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.1.0/keystore-tui-aarch64-apple-darwin.tar.xz"
      sha256 "49a66a4977b73c1d80276e3e1a3a257bb18684883878d0d5d50af2506e28a78b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.1.0/keystore-tui-x86_64-apple-darwin.tar.xz"
      sha256 "1dec085924c2df0a09ea8c5aca16240367706da7b539dce054f295773245ff66"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.1.0/keystore-tui-aarch64-unknown-linux-musl.tar.xz"
      sha256 "5f24bb97dcb513d15d7dd5f1e9a98ddd2ba49d53726089da86bb43db277c2ba6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.1.0/keystore-tui-x86_64-unknown-linux-musl.tar.xz"
      sha256 "e2bc80cf6a509b8e7ce97ae4fa0a412450287c735af2023749339aea75ae5fa6"
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
