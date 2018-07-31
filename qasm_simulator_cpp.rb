class QasmSimulatorCpp < Formula
  desc "C++ quantum circuit simulator with realistic noise"
  homepage "https://qiskit.org/"
  url "https://github.com/Qiskit/qiskit-terra/archive/0.5.7.tar.gz"
  sha256 "d94672c9857f524dbb6a15d44511eb3dbef219a10de05a99fba1ce59b1db5325"

  option "with-openmp", "Enable OpenMP multithreading"

  depends_on "cmake" => :build
  depends_on "gcc" => :build if build.with? "openmp"

  fails_with :clang if build.with? "openmp"

  # ONLY build qasm simulator
  patch :DATA

  def install
    if build.with? "openmp"
      args = ["-DCMAKE_CXX_COMPILER=g++-7"]
    else
      args = ["-DSTATIC_LINKING=False"]
    end

    system "cmake", ".", *std_cmake_args, *args
    system "make", "install"
  end

  test do
    (testpath/"input.json").write <<~EOS
      {
          "id": "test_qobj",
          "config": {
              "shots": 4,
              "seed": 0,
              "initial_state": [1, 0, 0, 1]
          },
          "circuits": []
      }
    EOS

    system "#{bin}/qasm_simulator_cpp", "input.json"
  end
end

__END__
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -7,25 +7,8 @@ set(QISKIT_VERSION ${PROJECT_VERSION} CACHE INTERNAL "VERSION OF QISKIT")

 include(cmake/defaults.cmake)

-if (ENABLE_TARGETS_NON_PYTHON)
-    # Add Toolchain utilities for C++ sources
-    include(cmake/toolchain-utils.cmake)
+# Add Toolchain utilities for C++ sources
+include(cmake/toolchain-utils.cmake)

-    # Add C++ Qiskit Simulator
-    add_subdirectory(${PROJECT_SOURCE_DIR}/src/qasm-simulator-cpp)
-
-    # Add Python distributable package generator
-    include(cmake/python-build.cmake)
-    add_pypi_package_target(pypi_package both)
-endif()
-
-include(cmake/tests.cmake)
-
-if (ENABLE_TARGETS_QA)
-    # Add QA tools: lint, style and sphinx
-    include(cmake/code-qa.cmake)
-    add_lint_target()
-    add_code_style_target()
-    add_doc_target(html "./" "_build/")
-    add_coverage_target()
-endif()
+# Add C++ Qiskit Simulator
+add_subdirectory(${PROJECT_SOURCE_DIR}/src/qasm-simulator-cpp)
--- a/src/qasm-simulator-cpp/CMakeLists.txt
+++ b/src/qasm-simulator-cpp/CMakeLists.txt
@@ -152,3 +152,7 @@ endif()
 # Tests
 # TODO: Enable them when ready
 #add_subdirectory(${QASM_SIMULATOR_CPP_DIR}/test)
+
+install(TARGETS qasm_simulator_cpp
+       RUNTIME DESTINATION bin
+)
