from conan import ConanFile
from conan.tools.cmake import CMake, cmake_layout

class EmbeddedFirmwareConan(ConanFile):
    name = "embedded_firmware"
    version = "1.0"

    # Settings used to build the package
    settings = "os", "compiler", "build_type", "arch"

    # Dependencies
    requires = "gtest/1.14.0"

    # Generators used to integrate with CMake
    generators = "CMakeToolchain", "CMakeDeps"

    # No source packaging for now
    exports_sources = "CMakeLists.txt", "src/*", "tests/*"

    def layout(self):
        cmake_layout(self)

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def test(self):
        self.run("./tests", cwd=self.cpp.build.bindirs[0])