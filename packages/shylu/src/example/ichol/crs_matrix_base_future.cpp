#include <Kokkos_Core.hpp>

#include <Kokkos_TaskPolicy.hpp>
#include <impl/Kokkos_Serial_TaskPolicy.hpp>

#include <Kokkos_Qthread.hpp>
#include <Qthread/Kokkos_Qthread_TaskPolicy.hpp>

#include "util.hpp"

#include "crs_matrix_base.hpp"

using namespace std;

typedef Kokkos::Serial space_type;
typedef Kokkos::Future<int,space_type> future_type;

class SimpleTask : public Example::Disp {
private:
  double _data;
  future_type _f;

public:
  SimpleTask() 
    : _data(1.0), 
      _f() 
  { }
  SimpleTask(const SimpleTask &b) 
    : _data(b._data), 
      _f(b._f) 
  { }

  ostream& showMe(ostream &os) const {  
    return (os << _data);
  }
};

typedef class SimpleTask value_type;
typedef int              ordinal_type;
typedef size_t           size_type;

typedef Example::CrsMatrixBase<value_type,ordinal_type,size_type,space_type> CrsMatrixBase;

int main (int argc, char *argv[]) {

  Kokkos::initialize();
  cout << "Default execution space initialized = " 
       << typeid(Kokkos::DefaultExecutionSpace).name()
       << endl;

  { // Test on an empty matrix
    CrsMatrixBase A("Empty A");
  }

  { // Test on matrix allocation
    CrsMatrixBase A("A, 3x3 Allocated", 3, 3, 9);

    cout << A << endl;
  }

  Kokkos::finalize();

  return 0;
}