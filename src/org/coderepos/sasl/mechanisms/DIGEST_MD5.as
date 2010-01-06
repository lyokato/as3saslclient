package org.coderepos.sasl.mechanisms
{
    import org.coderepos.sasl.exceptions.SASLBadChallengeError;
    import org.coderepos.sasl.SASLConfig;

    public class DIGEST_MD5 implements ISASLMechanism
    {
        private var _config:SASLConfig;
        private var _step:uint;

        public function DIGEST_MD5(config:SASLConfig)
        {
            _config      = config;
            _minssf      = 0;
            _maxssf      = Math.floor(2**31) - 1;
            _maxbuf      = 0xffffff;
            _externalssf = 0;
        }

        private function reset():void
        {
            _step = 0;
        }

        public function get name():String
        {
            return "DIGEST-MD5";
        }

        public function start():String
        {
            reset();
            return "";
        }

        public function step(challenge:String):String
        {
            var params:Object = parseChallengeString(challenge);
            if (!validateChallengeParams(params))
                throw new SASLBadChallengeError("");

            if (_step == 1) {
                if (!("rspauth" in params)) {
                    throw new SASLBadChallengeError("");
                }
                if (!(_rspauth != null && _rspauth == params["rspauth"])) {
                    throw new SASLBadChallengeError("");
                }
                // completed
                return "";
            }

            return null;
        }

        private function parseChallengeString(str:String):Object
        {
            var pairs:Array = str.split(/\s,\s/);
            for each(var pair:String in pairs) {

            }
        }

        private function validateChallengeParams(params:Object):Boolean
        {

        }
    }
}

