class KeystoreTui < Formula
  desc "Read-only terminal UI for inspecting JKS, JCEKS, and PKCS12 keystores, certificates, and certificate requests"
  homepage "https://github.com/codecraft21/keystore-tui"
  version "1.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.0.1/keystore-tui-aarch64-apple-darwin.tar.xz"
      sha256 "774f698744a9e172405cd7991824dec49033894a7001b21dae3a36c032c6e5fe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.0.1/keystore-tui-x86_64-apple-darwin.tar.xz"
      sha256 "4c2ffbc92ec53ff824a3cd1cf9670169b56fc5a6bc2525536340a4cf1d3fde34"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.0.1/keystore-tui-aarch64-unknown-linux-musl.tar.xz"
      sha256 "077dcd9c71c57248b64bd020fb6c67710092a56baff8354fbfc23f6b9f9467d9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.0.1/keystore-tui-x86_64-unknown-linux-musl.tar.xz"
      sha256 "458b396b6b3f9715b8d64293df64b71c415616bb702e9ffb24670f8af47c7da1"
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
