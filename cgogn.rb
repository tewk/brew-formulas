# This file is licensed under the GNU General Public License v3.0
require 'formula'

class Cgogn < Formula


  homepage 'http://cgogn.unistra.fr/'
  head "https://github.com/cgogn/CGoGN.git", :using => :git

  depends_on 'cmake' => :build
  depends_on 'suite-sparse'
  depends_on "qt"
  depends_on "libqglviewer"
  depends_on "glew"

  def patches
    # patch the examples to compile on Mac OS X after installation
    DATA
  end

  def install
    cd "ThirdParty/build"
    system "cmake", "..", *std_cmake_args
    system "make"
    system "make", "install"
    cd "../../build"
    system "cmake", "..", *std_cmake_args
    system "make"
    cd "../SCHNApps/build"
    system "cmake", "..", *std_cmake_args
    system "make"
  end
end

__END__
diff --git a/ThirdParty/Zinri/CMakeLists.txt b/ThirdParty/Zinri/CMakeLists.txt
index fb0b668..c210e8c 100644
--- a/ThirdParty/Zinri/CMakeLists.txt
+++ b/ThirdParty/Zinri/CMakeLists.txt
@@ -10,4 +10,8 @@ file(
        ${CMAKE_CURRENT_SOURCE_DIR}/*.c
 )

+
+
 add_library( Zinri ${source_files} )
+
+TARGET_LINK_LIBRARIES( Zinri z )
diff --git a/cmake_modules/FindQGLViewer.cmake b/cmake_modules/FindQGLViewer.cmake
index 8aa5359..491b18f 100644
--- a/cmake_modules/FindQGLViewer.cmake
+++ b/cmake_modules/FindQGLViewer.cmake
@@ -8,9 +8,10 @@
 #

 find_path(QGLVIEWER_INCLUDE_DIR
-          NAMES QGLViewer/qglviewer.h
+          NAMES qglviewer.h QGLViewer/qglviewer.h
           PATHS /usr/include
                 /usr/local/include
+               /usr/local/lib/QGLViewer.framework/Headers
                 ENV QGLVIEWERROOT
          )

@@ -18,6 +19,7 @@ find_library(QGLVIEWER_LIBRARY_RELEASE
              NAMES qglviewer-qt4 qglviewer QGLViewer QGLViewer2
              PATHS /usr/lib
                    /usr/local/lib
+                  /usr/local/lib/QGLViewer.framework/Versions/2
                    ENV QGLVIEWERROOT
                    ENV LD_LIBRARY_PATH
                    ENV LIBRARY_PATH

