package suite
{
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;

    import org.coderepos.sasl.SASLConfig;
    import org.coderepos.sasl.SASLMechanismFactory;
    import org.coderepos.sasl.mechanisms.ISASLMechanism;
    import org.coderepos.sasl.mechanisms.CRAM_MD5;

    public class CRAM_MD5Test extends TestCase
    {
        public function CRAM_MD5Test(method:String)
        {
            super(method);
        }

        public static function suite():TestSuite
        {
            var ts:TestSuite = new TestSuite();
            ts.addTest(new CRAM_MD5Test("testResponse"));
            return ts;
        }

        public function testResponse():void
        {
            var config:SASLConfig = new SASLConfig("myauthcid", "fred", "myauthzid");
            var mech:ISASLMechanism = new CRAM_MD5(config);
            assertEquals("mech name", "CRAM-MD5", mech.name);
            var start:String = mech.start();
            assertEquals("SASL CRAM_MD5 start", "", start);
            var step:String = mech.step("xyz");
            assertEquals("SASL CRAM_MD5 step", "myauthcid 36c931fe47f3fe9c7adbf810b3c7c4ad", step);
        }
    }
}

