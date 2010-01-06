package suite
{
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;

    import org.coderepos.sasl.SASLConfig;
    import org.coderepos.sasl.SASLMechanismFactory;
    import org.coderepos.sasl.mechanisms.ISASLMechanism;
    import org.coderepos.sasl.mechanisms.LOGIN;

    public class LOGINTest extends TestCase
    {
        public function LOGINTest(method:String)
        {
            super(method);
        }

        public static function suite():TestSuite
        {
            var ts:TestSuite = new TestSuite();
            ts.addTest(new LOGINTest("testResponse"));
            return ts;
        }

        public function testResponse():void
        {
            var config:SASLConfig = new SASLConfig("myauthcid", "mypass", "myauthzid");
            var mech:ISASLMechanism = new LOGIN(config);
            assertEquals("mech name", "LOGIN", mech.name);
            var start:String = mech.start();
            assertEquals("SASL LOGIN start", "", start);
            var step_unknown:String = mech.step("unknown");
            assertEquals("unknown", "", step_unknown);
            var step_username:String = mech.step("username");
            assertEquals("username", "myauthcid", step_username);
            var step_password:String = mech.step("password");
            assertEquals("password", "mypass", step_password);
        }
    }
}

