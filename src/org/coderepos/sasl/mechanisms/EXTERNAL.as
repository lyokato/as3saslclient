package org.coderepos.sasl.mechanisms
{
    import org.coderepos.sasl.SASLConfig;

    public class EXTERNAL implements ISASLMechanism
    {
        private var _config:SASLConfig;

        public function EXTERNAL(config:SASLConfig)
        {
            _config = config;
        }

        public function get name():String
        {
            return "EXTERNAL";
        }

        public function start():String
        {
            var username:String = (_config.username != null)
                ? _config.username : "";
            return username;
        }

        public function step(challenge:String):String
        {
            // XXX: throw new Error("")
            return null;
        }
    }
}

