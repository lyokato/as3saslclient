package suite
{
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;

    import org.coderepos.sasl.SASLConfig;
    import org.coderepos.sasl.SASLMechanismFactory;
    import org.coderepos.sasl.mechanisms.ISASLMechanism;
    import org.coderepos.sasl.mechanisms.EXTERNAL;

    public class EXTERNALTest extends TestCase
    {
        public function EXTERNALTest(method:String)
        {
            super(method);
        }

        public static function suite():TestSuite
        {
            var ts:TestSuite = new TestSuite();
            ts.addTest(new EXTERNALTest("testResponse"));
            return ts;
        }

        public function testResponse():void
        {
            var config:SASLConfig = new SASLConfig("myauthcid", "mypass", "myauthzid");
            var mech:ISASLMechanism = new EXTERNAL(config);
            assertEquals("mech name", "EXTERNAL", mech.name);
            var start:String = mech.start();
            assertEquals("SASL EXTERNAL start", "myauthcid", start);
            var step:String = mech.step("dummy challenge");
            assertNull(step);
        }
    }
}

