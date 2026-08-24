# Fórmula espejo: apunta al código del propio autor, no a un fork.
#
# Pinchada a un commit de main y NO a la 0.1.0 de crates.io, por un motivo
# concreto y comprobado: en la 0.1.0 publicada, `click` llama a `ctx.activate()`
# y después mueve el cursor real para clicar por coordenadas. Es decir, roba el
# foco y puede aterrizar en otra ventana si algo se movió. En main, la
# estrategia por defecto es `cg-pid` — entrega por PID, sin activar la app ni
# tocar el cursor — que es la única razón por la que mav necesita esta
# herramienta y no le basta con Peekaboo.
#
# El proyecto no tiene releases ni tags (0 y 0), así que no hay nada estable a
# lo que apuntar. Cuando publiquen uno con la entrega por PID, esto pasa a ser
# una url de release normal.
class Axcli < Formula
  desc "macOS Accessibility API CLI for driving native apps from the terminal"
  homepage "https://github.com/andelf/axcli"
  url "https://github.com/andelf/axcli/archive/ce6ef8e65d210fbcf4f8d3d8d8d4bbeda5d2fde6.tar.gz"
  version "0.1.0-ce6ef8e"
  sha256 "87526ef3c742e0b3d6c86ab83efe4b7ef8201b6c30a359e266242937d9d44c4b"
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

    # La razón de existir de esta fórmula: que exista la entrega por PID. Si un
    # día se pierde, este test tiene que romperse en vez de dejar pasar una
    # versión que roba el foco.
    assert_match "cg-pid", shell_output("#{bin}/axcli click --help 2>&1", 0)

    # Sin permiso de accesibilidad, cualquier comando con destino muere con ese
    # mensaje y código 1, que es lo esperable en un runner de CI.
    output = shell_output("#{bin}/axcli click --app Finder 'AXWindow' 2>&1", 1)
    assert_match(/accessibility not granted|locator|error/, output)
  end
end
