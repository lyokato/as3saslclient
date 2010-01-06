package org.coderepos.sasl.mechanisms
{
    import org.coderepos.sasl.SASLConfig;

    public class LOGIN implements ISASLMechanism
    {
        private var _config:SASLConfig;

        public function LOGIN(config:SASLConfig)
        {
            _config = config;
        }

        public function get name():String
        {
            return "LOGIN";
        }

        public function start():String
        {
            return "";
        }

        public function step(challenge:String):String
        {
            var res:String = "";
            if (challenge.match(/password/i) != null)
                res = _config.password;
            else if (challenge.match(/username/i) != null)
                res = _config.username;
            return res;
        }
    }
}

