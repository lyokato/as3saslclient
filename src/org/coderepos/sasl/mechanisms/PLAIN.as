package org.coderepos.sasl.mechanisms
{
    import org.coderepos.sasl.SASLConfig;

    public class PLAIN implements ISASLMechanism
    {
        private var _config:SASLConfig;

        public function PLAIN(config:SASLConfig)
        {
            _config = config;
        }

        public function get name():String
        {
            return "PLAIN";
        }

        public function start():String
        {
            var authcid:String = (_config.authcid != null)
                ? _config.authcid : "";
            var password:String = (_config.password != null)
                ? _config.password : "";
            var authzid:String = (_config.authzid != null)
                ? _config.authzid : "";

            return authzid + "\0" + authcid + "\0" + password;
        }

        public function step(challenge:String):String
        {
            // XXX: throw new Error("")
            return null;
        }
    }
}

