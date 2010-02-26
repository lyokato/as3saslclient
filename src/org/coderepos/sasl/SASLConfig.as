package org.coderepos.sasl
{
    public class SASLConfig
    {
        private var _user:String;
        private var _pass:String;
        private var _authzid:String;

        public function SASLConfig(user:String="", pass:String="", auth:String=null)
        {
            _user    = user;
            _pass    = pass;
            _authzid = auth;
        }

        public function get username():String
        {
            return _user;
        }

        // synonym for username
        public function get authcid():String
        {
            return _user;
        }

        public function get password():String
        {
            return _pass;
        }

        public function get authzid():String
        {
            return _authzid;
        }
    }
}

