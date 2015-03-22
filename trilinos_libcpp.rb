require 'formula'

class TrilinosLibcpp < Formula
  homepage 'http://trilinos.sandia.gov'
  url 'http://trilinos.org/oldsite/download/files/trilinos-11.14.1-Source.tar.gz'
  sha1 '84c7633e387e54c80e037998590b22d3bc71f32b'
  #url 'http://trilinos.org/oldsite/download/files/trilinos-11.12.1-Source.tar.gz'
  #sha1 '84cd7f4fba7946e3d391f03d52902954bb4dcd60'
  #url 'http://trilinos.sandia.gov/download/files/trilinos-11.10.2-Source.tar.gz'
  #sha1 'f7442cef35c4dea4f3535e0859deda88f68e72fc'
  #url 'http://trilinos.sandia.gov/download/files/trilinos-11.4.3-Source.tar.gz'
  #sha1 'ea0c09841ec9c1ceb7ea54c384255e34bc60225b'

  option "with-boost",    "Enable Boost support"
  # We have build failures with scotch. Help us on this, if you can!
  # option "with-scotch",   "Enable Scotch partitioner"
  option "with-netcdf",   "Enable Netcdf support"
  option "with-teko",     "Enable 'Teko' secondary-stable package"
  option "with-shylu",    "Enable 'ShyLU' experimental package"
  option 'with-minsizerel', 'Enable minimal size release build'
  option 'with-release-debug', 'Enable release with debug build'
  option 'with-debug', 'Enable debug build'

  depends_on :mpi => [:cc, :cxx]
  depends_on 'cmake' => :build
  depends_on 'boost' => :optional
  depends_on 'scotch' => :optional
  depends_on 'netcdf' => :optional

  def install

    args = std_cmake_args
    # args << "-DBUILD_SHARED_LIBS=ON"
    # args << "-DTPL_ENABLE_MPI:BOOL=ON"
    # args << "-DTPL_ENABLE_BLAS=ON"
    # args << "-DTPL_ENABLE_LAPACK=ON"
    # args << "-DTPL_ENABLE_Zlib:BOOL=ON"
    # args << "-DTrilinos_ENABLE_ALL_PACKAGES=ON"
    # args << "-DTrilinos_ENABLE_ALL_OPTIONAL_PACKAGES=ON"
    # args << "-DTrilinos_ENABLE_Fortran:BOOL=OFF"
    # args << "-DTrilinos_ENABLE_EXAMPLES:BOOL=OFF"
    # args << "-DTrilinos_VERBOSE_CONFIGURE:BOOL=OFF"
    # args << "-DZoltan_ENABLE_ULLONG_IDS:Bool=ON"

    args << "-DCMAKE_CXX_FLAGS:STRING='-stdlib=libc++'"
    args << "-DTrilinos_ENABLE_Fortran:BOOL=OFF"
    args << "-DTrilinos_ENABLE_Epetra:BOOL=ON"
    args << "-DTrilinos_ENABLE_Teuchos:BOOL=ON"
    args << "-DTrilinos_ENABLE_AztecOO:BOOL=ON"
    args << "-DTrilinos_ENABLE_Amesos:BOOL=ON"
    args << "-DTrilinos_ENABLE_Anasazi:BOOL=ON"
    args << "-DTrilinos_ENABLE_SuperLU:BOOL=ON"
    args << "-DTrilinos_ENABLE_Belos:BOOL=ON"
    args << "-DTrilinos_ENABLE_Tpetra:BOOL=ON"
    args << "-DTrilinos_ENABLE_Kokkos:BOOL=ON"
    args << "-DTPL_ENABLE_MPI:BOOL=ON"
    args << "-DMPI_USE_COMPILER_WRAPPERS:BOOL=OFF"
    args << "-DTPL_SuperLU_INCLUDE_DIRS:STRING=/usr/local/Cellar/superlu/4.3/include/superlu"
    args << "-DTPL_SuperLU_LIBRARY_DIRS:STRING=/usr/local/Cellar/superlu/4.3/lib"
    args << "-DTPL_SuperLU_LIBRARIES:STRING=/usr/local/Cellar/superlu/4.3/lib/libsuperlu.a"
    args << "-DSuperLU_LIBRARY_NAMES:STRING=superlu.4.3"
    args << "-DTPL_ENABLE_SuperLU:BOOL=ON"
    args << "-DSuperLU_INCLUDE_DIRS:STRING=/usr/local/Cellar/superlu/4.3/"

    # Extra non-default packages
    args << "-DTrilinos_ENABLE_ShyLU:BOOL=ON"  if build.with? 'shylu'
    args << "-DTrilinos_ENABLE_Teko:BOOL=ON"   if build.with? 'teko'

    # Third-party libraries
    args << "-DTPL_ENABLE_Boost:BOOL=ON"    if build.with? 'boost'
    args << "-DTPL_ENABLE_Scotch:BOOL=ON"   if build.with? 'scotch'
    args << "-DTPL_ENABLE_Netcdf:BOOL=ON"   if build.with? 'netcdf'


    if build.with? 'debug'
	    args << '-DCMAKE_BUILD_TYPE=Debug'
    elsif build.with? 'release-debug'
	    args << '-DCMAKE_BUILD_TYPE=RelWithDebInfo'
    elsif build.with? 'minsizerel'
	    args << '-DCMAKE_BUILD_TYPE=MinSizeRel'
    end

    mkdir 'build' do
      system "cmake", "..", *args
      system "make install"
    end

  end

end

