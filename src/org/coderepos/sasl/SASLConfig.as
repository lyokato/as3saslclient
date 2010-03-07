/*
Copyright (c) Lyo Kato (lyo.kato _at_ gmail.com)

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION 
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
*/

package org.coderepos.sasl
{
    public class SASLConfig
    {
        private var _user:String;
        private var _pass:String;
        private var _authzid:String;
        private var _service:String;
        private var _host:String;

        public function SASLConfig(user:String="", pass:String="", auth:String=null, service:String=null, host:String=null)
        {
            _user    = user;
            _pass    = pass;
            _authzid = auth;
            _service = service;
            _host    = host;
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

        public function get service():String
        {
            return (_service != null) ? _service : "";
        }

        public function get host():String
        {
            return (_host != null) ? _host : "";
        }
    }
}

