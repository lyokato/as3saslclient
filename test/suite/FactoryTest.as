package suite
{
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;

    import org.coderepos.sasl.SASLConfig;
    import org.coderepos.sasl.SASLMechanismFactory;
    import org.coderepos.sasl.mechanisms.ISASLMechanism;
    import org.coderepos.sasl.mechanisms.PLAIN;
    import org.coderepos.sasl.mechanisms.LOGIN;
    import org.coderepos.sasl.mechanisms.EXTERNAL;

    public class FactoryTest extends TestCase
    {
        public function FactoryTest(method:String)
        {
            super(method);
        }

        public static function suite():TestSuite
        {
            var ts:TestSuite = new TestSuite();
            ts.addTest(new FactoryTest("testResponse"));
            return ts;
        }

        public function testResponse():void
        {
            var config:SASLConfig = new SASLConfig("myauthcid", "mypass", "myauthzid");
            var factory:SASLMechanismFactory = new SASLMechanismFactory();
            factory.supportMechanism(new PLAIN(config));
            factory.supportMechanism(new LOGIN(config));
            factory.supportMechanism(new EXTERNAL(config));
            var unknown:ISASLMechanism = factory.getMechanism("DIGEST-MD5");
            assertNull(unknown);
            var mech:ISASLMechanism = factory.getMechanism("PLAIN");
            assertNotNull(mech);
            assertEquals("mech name", "PLAIN", mech.name);
            var start:String = mech.start();
            assertEquals("SASL PLAIN start", "myauthzid\0myauthcid\0mypass", start);
            var step:String = mech.step("dummy challenge");
            assertNull(step);
        }
    }
}

