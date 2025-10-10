
int test_lbuf(int res0, int m, int n) {
  int res = res0;
  for(int i = 0; i < m;) {
    res += i*2;
    i += n;
  } 
  return res;
}

