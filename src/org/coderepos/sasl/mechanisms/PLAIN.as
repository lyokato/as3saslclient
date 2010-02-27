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
            var nullChar:String = String.fromCharCode(0);
            return authzid + nullChar + authcid + nullChar + password;
        }

        public function step(challenge:String):String
        {
            // XXX: throw new Error("")
            return null;
        }
    }
}

