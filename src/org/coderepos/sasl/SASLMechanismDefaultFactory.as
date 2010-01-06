package org.coderepos.sasl
{
    import org.coderepos.sasl.mechanisms.PLAIN;
    import org.coderepos.sasl.mechanisms.LOGIN;
    import org.coderepos.sasl.mechanisms.ANONYMOUS;
    import org.coderepos.sasl.mechanisms.EXTERNAL;
    import org.coderepos.sasl.mechanisms.CRAM_MD5;
    //import org.coderepos.sasl.mechanisms.DIGEST_MD5;
    //import org.coderepos.sasl.mechanisms.GSSAPI;

    public class SASLMechanismDefaultFactory extends SASLMechanismFactory
    {
        private var _config:SASLConfig;

        public function SASLMechanismDefaultFactory(authcid:String, 
            password:String="", authzid:String="")
        {
            var config:SASLConfig = new SASLConfig(authcid, password, authzid);
            supportMechanism(new PLAINTEXT(config));
            supportMechanism(new LOGIN(config));
            supportMechanism(new ANONYMOUS(config));
            supportMechanism(new EXTERNAL(config));
            supportMechanism(new CRAM_MD5(config));
            //supportMechanism(new DIGEST_MD5());
            //supportMechanism(new EXTERNAL());
        }
    }
}
