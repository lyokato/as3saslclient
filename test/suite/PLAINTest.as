package suite
{
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;

    import org.coderepos.sasl.SASLConfig;
    import org.coderepos.sasl.SASLMechanismFactory;
    import org.coderepos.sasl.mechanisms.ISASLMechanism;
    import org.coderepos.sasl.mechanisms.PLAIN;

    public class PLAINTest extends TestCase
    {
        public function PLAINTest(method:String)
        {
            super(method);
        }

        public static function suite():TestSuite
        {
            var ts:TestSuite = new TestSuite();
            ts.addTest(new PLAINTest("testResponse"));
            return ts;
        }

        public function testResponse():void
        {
            var config:SASLConfig = new SASLConfig("myauthcid", "mypass", "myauthzid");
            var mech:ISASLMechanism = new PLAIN(config);
            assertEquals("mech name", "PLAIN", mech.name);
            var start:String = mech.start();
            assertEquals("SASL PLAIN start", "myauthzid\0myauthcid\0mypass", start);
            var step:String = mech.step("dummy challenge");
            assertNull(step);
        }
    }
}

