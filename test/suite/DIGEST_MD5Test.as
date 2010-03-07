package suite
{
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;

    import org.coderepos.sasl.SASLConfig;
    import org.coderepos.sasl.SASLMechanismFactory;
    import org.coderepos.sasl.mechanisms.ISASLMechanism;
    import org.coderepos.sasl.mechanisms.DIGEST_MD5;

    public class DIGEST_MD5Test extends TestCase
    {
        public function DIGEST_MD5Test(method:String)
        {
            super(method);
        }

        public static function suite():TestSuite
        {
            var ts:TestSuite = new TestSuite();
            ts.addTest(new DIGEST_MD5Test("testParse"));
            ts.addTest(new DIGEST_MD5Test("testResponse"));
            return ts;
        }

        public function testParse():void
        {
            var config:SASLConfig = new SASLConfig("myauthcid", "fred", "myauthzid", "xmpp", "chat.facebook.com");
            var mech:DIGEST_MD5 = new DIGEST_MD5(config);
            var obj:Object = mech.parseChallenge('realm="elwood.innosoft.com",nonce="OA6MG9tEQGm2hh",qop="auth",algorithm=md5-sess,charset=utf-8');
            assertEquals('realm', obj['realm'], 'elwood.innosoft.com');
            assertEquals('nonce', obj['nonce'], 'OA6MG9tEQGm2hh');
            assertEquals('qop', obj['qop'], 'auth');
            assertEquals('algorithm', obj['algorithm'], 'md5-sess');
            assertEquals('charset', obj['charset'], 'utf-8');
        }

        public function testResponse():void
        {
            var config:SASLConfig = new SASLConfig("chris", "secret", null, "imap", "elwood.innosoft.com");
            var mech:DIGEST_MD5 = new DIGEST_MD5(config);
            mech.debugCNonce = "OA6MHXh6VqTrRk";
            var step:String = mech.step('realm="elwood.innosoft.com",nonce="OA6MG9tEQGm2hh",qop="auth",algorithm=md5-sess,charset=utf-8');
            var res:Object = mech.parseChallenge(step);
            var origin:Object = mech.parseChallenge('charset=utf-8,username="chris",realm="elwood.innosoft.com",nonce="OA6MG9tEQGm2hh",nc=00000001,cnonce="OA6MHXh6VqTrRk",digest-uri="imap/elwood.innosoft.com",response=d388dad90d4bbd760a152321f2143af7,qop=auth');

            assertEquals('same response', res['response'], origin['response']);


        }
    }
}

