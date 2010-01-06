package suite
{
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;

    import org.coderepos.sasl.SASLConfig;
    import org.coderepos.sasl.SASLMechanismFactory;
    import org.coderepos.sasl.mechanisms.ISASLMechanism;
    import org.coderepos.sasl.mechanisms.ANONYMOUS;

    public class ANONYMOUSTest extends TestCase
    {
        public function ANONYMOUSTest(method:String)
        {
            super(method);
        }

        public static function suite():TestSuite
        {
            var ts:TestSuite = new TestSuite();
            ts.addTest(new ANONYMOUSTest("testResponse"));
            return ts;
        }

        public function testResponse():void
        {
            var config:SASLConfig = new SASLConfig("myauthcid", "mypass", "myauthzid");
            var mech:ISASLMechanism = new ANONYMOUS(config);
            assertEquals("mech name", "ANONYMOUS", mech.name);
            var start:String = mech.start();
            assertEquals("SASL ANONYMOUS start", "myauthzid", start);
            var step:String = mech.step("dummy challenge");
            assertEquals("SASL ANONYMOUS step", "myauthzid", step);
        }
    }
}

