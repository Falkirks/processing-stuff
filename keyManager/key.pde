class bindKey {
  private IntList keylist;
  public bindKey() {
    keylist = new IntList();
  }
  public void pressKey(int key) {
    if (!keylist.hasValue(key)) keylist.append(key);
  }
  public void releaseKey(int key) {
    if (keylist.hasValue(key)) {
      for (int i = 0; i < keylist.size(); i++) {
        if (keylist.get(i) == key) {
          keylist.remove(i);
          return;
        }
      }
    }
  }
  public Boolean isPressed(int check){
    if (keylist.hasValue(check)) return true;
    return false;
  }
  public int[] get(){
    return keylist.array();
  }
  public int count(){
    return keylist.size();
  }
}

