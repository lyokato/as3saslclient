package org.coderepos.sasl.mechanisms
{
    import org.coderepos.sasl.SASLConfig;

    public class ANONYMOUS implements ISASLMechanism
    {
        private var _config:SASLConfig;

        public function ANONYMOUS(config:SASLConfig)
        {
            _config = config;
        }

        public function get name():String
        {
            return "ANONYMOUS";
        }

        public function start():String
        {
            return _config.authzid;
            //return _config.email;
        }

        public function step(challenge:String):String
        {
            return _config.authzid;
            //return _config.email;
        }
    }
}

