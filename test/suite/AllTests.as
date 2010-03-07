package suite {
  
  import flexunit.framework.TestSuite;  
  
  public class AllTests extends TestSuite {
    
    public function AllTests() {
      super();
      // Add tests here
      // For examples, see: http://code.google.com/p/as3flexunitlib/wiki/Resources
      addTest(PLAINTest.suite());
      addTest(ANONYMOUSTest.suite());
      addTest(LOGINTest.suite());
      addTest(EXTERNALTest.suite());
      addTest(CRAM_MD5Test.suite());
      addTest(DIGEST_MD5Test.suite());
      addTest(FactoryTest.suite());
    }
    
  }
  
}
