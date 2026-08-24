# Formula espejo: apunta al tarball que el propio autor publica en crates.io,
# no a un fork ni a binarios reconstruidos aquí. Actualizarla es cambiar
# version + sha256; el código sigue siendo suyo.
#
# Existe porque axcli no publica fórmula propia ni releases con binarios, y mav
# la necesita como driver de input en macOS: es la única de las dos herramientas
# que entrega eventos por PID sin robar el foco.
class Axcli < Formula
  desc "macOS Accessibility API CLI for driving native apps from the terminal"
  homepage "https://github.com/andelf/axcli"
  url "https://static.crates.io/crates/axcli/axcli-0.1.0.crate"
  sha256 "ef339289a521c98d3b4a14e96342dfe9f1161d21c81525ebf9aee848dd51f8a9"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/andelf/axcli.git", branch: "main"

  depends_on "rust" => :build
  # Envuelve el Accessibility API de macOS: no existe fuera de macOS.
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "axcli", shell_output("#{bin}/axcli --version")

    # Sin permiso de accesibilidad, cualquier comando con destino muere con ese
    # mensaje exacto y código 1. En un runner de CI eso es lo esperable, así que
    # el test acepta las dos salidas: lo que no puede pasar es que el binario no
    # arranque.
    output = shell_output("#{bin}/axcli --app Finder get role 'AXWindow' 2>&1", 1)
    assert_match(/accessibility not granted|locator|error/, output)
  end
end
